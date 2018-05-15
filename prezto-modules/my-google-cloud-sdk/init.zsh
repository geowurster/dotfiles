# Google Cloud Platform SDK configuration


GCP_SDK="${HOME}/google-cloud-sdk"
if [[ ! -d "${GCP_SDK}" ]]; then
    return 1
fi


source "${GCP_SDK}/path.zsh.inc"
source "${GCP_SDK}/completion.zsh.inc"
