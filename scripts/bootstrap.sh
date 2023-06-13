for project_id in "${ALL_PROJECTS[@]}"; do
  project_path="${REPOS_PATH}/${project_id}"

  # Only bootstrap projects that don't already exist in the repos directory
  if [[ ! -d "${project_path}" ]]; then
    git clone "git@github.com:pHARMaware/${project_id}.git" "${project_path}"

    if [[ -f "${project_path}/package.json" ]]; then
      yarn install --cwd "${project_path}"
    fi

    if [[ -f "${project_path}/.env.example" ]]; then
      cp "${project_path}/.env.example" "${project_path}/.env"
    fi

    case "${project_id}" in
      "types")
        yarn link --cwd "${project_path}"
        ;;
    esac
  fi
done
