import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue import DynamicFrame

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Script generated for node album
additionalOptions = {}
album_node1709001253098_df = (
    spark.read.format("delta")
    .options(**additionalOptions)
    .load("s3://project-spotify-oleh/staging/albums.csv")
)
album_node1709001253098 = DynamicFrame.fromDF(
    album_node1709001253098_df, glueContext, "album_node1709001253098"
)

# Script generated for node tracks
tracks_node1709001253354 = glueContext.create_dynamic_frame.from_options(
    format_options={"quoteChar": '"', "withHeader": True, "separator": ","},
    connection_type="s3",
    format="csv",
    connection_options={
        "paths": ["s3://project-spotify-oleh/staging/track.csv"],
        "recurse": True,
    },
    transformation_ctx="tracks_node1709001253354",
)

# Script generated for node artists
artists_node1709001253719 = glueContext.create_dynamic_frame.from_options(
    format_options={"quoteChar": '"', "withHeader": True, "separator": ","},
    connection_type="s3",
    format="csv",
    connection_options={
        "paths": ["s3://project-spotify-oleh/staging/artists.csv"],
        "recurse": True,
    },
    transformation_ctx="artists_node1709001253719",
)

# Script generated for node Join album & artist
Joinalbumartist_node1709001257401 = Join.apply(
    frame1=artists_node1709001253719,
    frame2=album_node1709001253098,
    keys1=["id"],
    keys2=["artist_id"],
    transformation_ctx="Joinalbumartist_node1709001257401",
)

# Script generated for node Join with tracks
Joinwithtracks_node1709001258346 = Join.apply(
    frame1=Joinalbumartist_node1709001257401,
    frame2=tracks_node1709001253354,
    keys1=["track_id"],
    keys2=["track_id"],
    transformation_ctx="Joinwithtracks_node1709001258346",
)

# Script generated for node Drop Fields
DropFields_node1709001403992 = DropFields.apply(
    frame=Joinwithtracks_node1709001258346,
    paths=["id", "`.track_id`"],
    transformation_ctx="DropFields_node1709001403992",
)

# Script generated for node Destination
Destination_node1709001420449 = glueContext.write_dynamic_frame.from_options(
    frame=DropFields_node1709001403992,
    connection_type="s3",
    format="glueparquet",
    connection_options={
        "path": "s3://project-spotify-oleh/data-warehouse/",
        "partitionKeys": [],
    },
    format_options={"compression": "snappy"},
    transformation_ctx="Destination_node1709001420449",
)

job.commit()
