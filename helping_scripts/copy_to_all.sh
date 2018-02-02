#!/bin/bash

nodes=('dev-precise', 'dev-xenial', 'kube-jenkins' 'kube-minion1' 'kube-minion2' 'kube-minion3' 'kube-master1' 'kube-master2' 'app0' 'app1' 'kube-etcd1' 'kube-etcd2' 'kube-etcd3')

# source
file_to_copy="$1"
if [ ! -f "$file_to_copy" ]; then
  echo "File ${file_to_copy} does not exist."
  exit 1
fi

# destination
where_to_copy="$2"
if [ "$where_to_copy" == "--same" ]; then
  where_to_copy="$file_to_copy"
fi
# don't prompt user if set
if [ "$3" == "--no-prompt" ]; then
  no_interactive="true"
fi

# set response if not interactive
if [ -z "$no_interactive" ]; then
  # double check locations
  echo "Are you sure you want to copy $file_to_copy to $where_to_copy on the following hosts?"
  for n in "${nodes[@]}"; do
    echo -n "$n; "
  done

  # read response
  echo ""
  echo -n "NO/yes: "
  read response
  if [ "$response" != "yes" ]; then
    echo "Exiting and not copying."
    exit 0
  fi
elif [ "$no_interactive" == "true" ]; then
  response="yes"
else
  # should never get here
  exit 1
fi

# do the mkdir and copy
for node in "${nodes[@]}"; do
  echo "Copying to $node... "
  # mkdir to ensure scp succeeds
  dir_path=$(dirname "$where_to_copy")
  echo "ssh $node mkdir -p ${dir_path}"
  ssh "$node" mkdir -p "$dir_path"
  if [ $? -ne 0 ]; then
    echo "error: mkdir did not succeed"
    exit 1
  fi
  echo "scp $file_to_copy highland@$node:${where_to_copy}"
  scp "$file_to_copy" highland@"$node":"${where_to_copy}"
  if [ $? -ne 0 ]; then
    echo "error: scp did not succeed"
    exit 1
  fi
done
