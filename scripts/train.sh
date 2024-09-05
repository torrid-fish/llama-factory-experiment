module purge
module load hpcfund
module load rocm
module load pytorch
source train/bin/activate
export PYTHONPATH="$WORK/train/env/lib/python3.9/site-packages:$PYTHONPATH"

CUDA_VISIBLE_DEVICES=0,1,2,3 accelerate launch \
    --config_file accelerate_config.yaml \
    LLaMA-Factory/src/train.py \
    --stage sft \
    --do_train True \
    --use_dora True \
    --model_name_or_path $WORK/llama-factory-experiment/Llama3.1-8B-Instruct-hf \
    --preprocessing_num_workers 16 \
    --finetuning_type lora \
    --template llama3 \
    --flash_attn auto \
    --dataset_dir data \
    --dataset medmcqa \
    --cutoff_len 1024 \
    --learning_rate 5e-05 \
    --num_train_epochs 1.5 \
    --max_samples 100000 \
    --per_device_train_batch_size 2 \
    --gradient_accumulation_steps 8 \
    --lr_scheduler_type cosine \
    --max_grad_norm 1.0 \
    --logging_steps 5 \
    --save_steps 100 \
    --warmup_steps 0 \
    --optim adamw_torch \
    --packing False \
    --report_to none \
    --output_dir saves/LLaMA3.1-8B-Chat/dora \
    --bf16 True \
    --plot_loss True \
    --ddp_timeout 180000000 \
    --include_num_input_tokens_seen True \
    --lora_rank 8 \
    --lora_alpha 16 \
    --lora_dropout 0 \
    --lora_target all