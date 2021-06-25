STEP=0x1
ADDRESS=0xFF200002

for i in {1..4}; do
        memtool -8 $ADDRESS =0x0
        printf -v ADDRESS '%#X' "$((ADDRESS + STEP))"
done

ADDRESS=0xFF200002
for ((i = 0 ; i < $1 ; i++)); do
        echo $ADDRESS
        memtool -8 $ADDRESS =0x1
        printf -v ADDRESS '%#X' "$((ADDRESS + STEP))"

done

memtool -8 0xFF200000 8

