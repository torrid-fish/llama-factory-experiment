module purge
module load hpcfund
module load rocm
module load pytorch
source eval/bin/activate
export PYTHONPATH="$WORK/eval/env/lib/python3.9/site-packages:$PYTHONPATH"


for i in {3200..4000..100}
do
    HIP_VISIBLE_DEVICES=0,1,2,3 \
        lm_eval --model hf \
        --model_args pretrained=Llama3.1-8B-Instruct-hf,peft=saves/LLaMA3.1-8B-Chat/lora/train_2024-09-05-01-25-35/checkpoint-$i \
        --tasks medmcqa \
        --num_fewshot 0 \
        --batch_size auto \
        --output_path result/ \
        --trust_remote_code
done
