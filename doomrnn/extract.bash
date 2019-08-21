export CUDA_VISIBLE_DEVICES=""

# c1 cores in paper, c2 in current machine 
# i.e., ZBOX1070 has only 4 cores, 64/4=16 batches
c1=64
c2=`cat /proc/cpuinfo | grep processor | wc -l`
batches=$((c1 / c2))
for b in `seq 1 $batches`;
do
  echo batch $b 
  # Launch one process per core
  for i in `seq 1 4`;
    do
      echo worker $i
      python extract.py &
      pids[${i}]=$!
      sleep 1.0
    done
  # Wait for all processes to finish
  for pid in ${pids[*]}; do
    wait $pid
  done
done
