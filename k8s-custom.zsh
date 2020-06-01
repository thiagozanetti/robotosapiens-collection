function k8s_prompt_info {
  echo $(kube_ps1)
}

function get_cluster_short {
  echo "$1" | cut -d . -f1
}
