
# Chat
if [ "$1" = "lora" ]
then
    CUDA_VISIBLE_DEVICES=0,1,2 llamafactory-cli chat \
        --model_name_or_path /home/torridfish/Llama3.1-8B-Instruct-hf \
        --template llama3 \
        --temperature 0 \
        --adapter_name_or_path checkpoint-1600 \
        --finetuning_type lora
elif [ "$1" = "base" ]
then
    CUDA_VISIBLE_DEVICES=0,1,2 llamafactory-cli chat \
        --model_name_or_path /home/torridfish/Llama3.1-8B-Instruct-hf \
        --temperature 0 \
        --template llama3 
fi