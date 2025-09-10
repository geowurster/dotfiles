# Google Cloud Platform SDK configuration


if [ ! "$(command -v gcloud)" ]; then
    return 1
fi


GCP_SDK=$(gcloud info --format='value(installation.sdk_root)')
source "${GCP_SDK}/path.zsh.inc"
source "${GCP_SDK}/completion.zsh.inc"

unset GCP_SDK
