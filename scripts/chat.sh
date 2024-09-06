# Chat
if [ "$1" = "lora" ]
then
    CUDA_VISIBLE_DEVICES=0,1,2,3 llamafactory-cli webchat \
        --model_name_or_path Llama3.1-8B-Instruct-hf \
        --template llama3 \
        --adapter_name_or_path saves/LLaMA3.1-8B-Chat/lora/checkpoint-1600 \
        --finetuning_type lora
elif [ "$1" = "base" ]
then
    CUDA_VISIBLE_DEVICES=0,1,2,3 llamafactory-cli webchat \
        --model_name_or_path Llama3.1-8B-Instruct-hf \
        --template llama3 
fi