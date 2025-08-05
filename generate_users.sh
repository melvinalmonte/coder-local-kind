kubectl config set-context --current --namespace coder

CURRENT_POD=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep coder-)
echo "Current coder pod: $CURRENT_POD"

kubectl exec -it -n coder $CURRENT_POD -- coder users create -u "mick-mouse" -e "mick.mouse@nodomain.com" -n "Mick Mouse" -p "dmWVE9aeyHjowtWX" --login-type password


for i in $(seq 1 100); do
    # Generate random password for each user
    PASSWORD=$(generate_password)
    
    # Create username and email with incrementing number
    USERNAME="user$i"
    EMAIL="user$i@example.com"
    FULL_NAME="Test User $i"
    
    echo "Creating user $i of 100: $USERNAME"
    
    # Create the user
    kubectl exec -it -n coder $CURRENT_POD -- coder users create \
        -u "$USERNAME" \
        -e "$EMAIL" \
        -n "$FULL_NAME" \
        -p "dmWVE9aeyHjowtWX" \
        --login-type password
done
