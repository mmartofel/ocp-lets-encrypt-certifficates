
# Clone or update acme.sh
echo "Cloning or updating acme.sh..."
echo

if [ -d "acme.sh" ]; then
    echo "acme.sh already exists — updating..."
    (cd acme.sh && git pull --ff-only) || true
else
    git clone https://github.com/neilpang/acme.sh
fi

# Portable interactive prompts (works in bash and zsh)
echo "Please provide your AWS credentials."
echo "These will be used by acme.sh to complete the DNS-01 challenge."
echo

printf "AWS Access Key ID: "
read -r AWS_ACCESS_KEY_ID

# hide input for secret
printf "AWS Secret Access Key: "
stty -echo
read -r AWS_SECRET_ACCESS_KEY
stty echo
printf "\n"

# Export so that acme.sh can use them
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"

echo "You have provided the following AWS credentials:"
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
echo
echo "AWS credentials set."
