detect_mem() {
  if [ "$MEM_AVAILABLE" != "" ]; then
    echo $MEM_AVAILABLE
  else
    local limit=$(ulimit -u)
    local mem

    case $limit in
    256) mem=512;;
    512) mem=1024;;
    32768) mem=8192;;
    *) mem=$1;;
    esac

    echo $mem
  fi
}

provide_environment() {
  let MEM_AVAILABLE=$(detect_mem 512)
  if [[ "$PROCESS_MEM" != "" ]]; then
    let PROCESS_MEM=$PROCESS_MEM
  else
    let PROCESS_MEM=$MEM_AVAILABLE
  fi
  let PROCESS_COUNT=$MEM_AVAILABLE/$PROCESS_MEM

  export MEM_AVAILABLE=$MEM_AVAILABLE
  export PROCESS_MEM=$PROCESS_MEM
  export PROCESS_COUNT=$PROCESS_COUNT

  echo "at=info MEM_AVAILABLE=$MEM_AVAILABLE PROCESS_MEM=$PROCESS_MEM PROCESS_COUNT=$PROCESS_COUNT"
}

if [[ "$PROCESS_MEM" != "" ]]; then
  provide_environment
  alias node="node --max_old_space_size=$PROCESS_MEM --use_idle_notification"
else
  provide_environment
fi
