#!/bin/bash


# References:
# https://www.shruggingface.com/blog/how-i-used-stable-diffusion-and-dreambooth-to-create-a-painted-portrait-of-my-dog
# https://replicate.com/blog/dreambooth-api

[[ -z "${REPLICATE_API_TOKEN}" ]] && echo "ERROR: API token is not set" && exit 1
curl -X POST \
    -H "Authorization: Token $REPLICATE_API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{
            "input": {
                "instance_prompt": "a photo of a shk dog",
                "class_prompt": "photograph of a light colored medium size Havanese dog, 4k hd, high detail photograph, sharp lens, realistic, highly detailed, fur",
                "instance_data": "https://sherlock-photos.s3.us-east-2.amazonaws.com/sherlock.zip",
                "max_train_steps": 4000
            },
            "model": "dfujiwara/sherlock-v1",
            "trainer_version": "cd3f925f7ab21afaef7d45224790eedbb837eeac40d22e8fefe015489ab644aa",
            "webhook_completed": "https://5dff-136-25-19-32.ngrok.io"
        }' \
    https://dreambooth-api-experimental.replicate.com/v1/trainings | jq

echo "Use the following command to check the status of the training"
echo "REPLICATE_API_TOKEN=<token> curl -H "Authorization: Token $REPLICATE_API_TOKEN" https://dreambooth-api-experimental.replicate.com/v1/trainings/<JobId> | jq"