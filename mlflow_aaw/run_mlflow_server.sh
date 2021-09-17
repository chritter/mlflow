



# sqlite for backend, artifact local disk
#mlflow server --backend-store-uri sqlite:///mydb.sqlite --default-artifact-root /home/jovyan/seldonproject/mlflow --host 0.0.0.0






source /vault/secrets/minio-standard-tenant-1
export MLFLOW_S3_ENDPOINT_URL=$MINIO_URL
export MINIO_URL="https://minio-standard-tenant-1.covid.cloud.statcan.ca"
#export MLFLOW_S3_IGNORE_TLS=true # as we use https
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# mc cp mlflow standard-tenant-1/seldonp --recursive



if [ -z $MLFLOW_S3_ENDPOINT_URL ]; then
  echo >&2 "MLFLOW_S3_ENDPOINT_URL must be set"
  exit 1
fi

if [ -z $AWS_ACCESS_KEY_ID ]; then
  echo >&2 "AWS_ACCESS_KEY_ID must be set"
  exit 1
fi

if [ -z $AWS_SECRET_ACCESS_KEY ]; then
  echo >&2 "AWS_SECRET_ACCESS_KEY must be set"
  exit 1
fi

# killall gunicorn for killing the server, if not shutdown properly

mlflow server --backend-store-uri sqlite:///mydb.sqlite \
              --default-artifact-root s3://seldonp/mlflow/ \
              --port 5000 \
              --host 0.0.0.0