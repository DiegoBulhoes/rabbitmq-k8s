# RabbitMQ no Kubernets

Esse laboratório tem como objetivo de fornecer uma ambiente para praticar a ferramenta Kubernetes usando o [GKE](https://cloud.google.com/kubernetes-engine?hl=pt-br), [Prometheus Operator](https://prometheus.io/), [Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/) e [Grafana](https://grafana.com/).

Para inicializar o laboratório é necessário criar uma conta de serviço com os seguintes papeis

```text
Administrador de compute 
Administrador de cluster do Kubernetes Engine 
Usuário da conta de serviço
```

O Terraform irá instanciar cluster básico com 2 nodes cada um em uma região diferente. Para passar as credenciais basta popular a variável de ambiente **GOOGLE_APPLICATION_CREDENTIALS** com o caminho da keyfile.json.

```shell
export GOOGLE_APPLICATION_CREDENTIALS=/path/keyfile.json 
```

## Inicializar o laboratório

Clonar o projeto

```shell
git clone https://github.com/DiegoBulhoes/rabbitmq-k8s 
```

Renomeie o arquivo [terraform.tfvars.exemple](terraform.tfvars.exemple) para terraform.tfvars (nesse arquivo irá conter todas as variáveis para criar as instâncias no GCP).

Para inicializar os modulos, execute o seguinte comando:

```shell
terraform init 
```

Para verificar se os arquivos possuem algum erro de sintaxe ou de configuração das instâncias execute o seguinte comando:

```shell
terraform plan 
```

Após a verificação do _plan_ execulte o seuinte comando para realizar o processo de instanciação

```shell
terraform apply -var="install_apps=false" 
```

Se tudo estiver ok a saída será similar a esta:

```text

Apply complete! Resources: 2 added, 0 changed, 0 destroyed. 

Outputs: 

kubernetes_cluster_name = project-gke 

region = us-central1 
```

Agora será necessário configurar o kubectl com o proposito de instalar as aplicações.

```shell
gcloud container clusters get-credentials <nome_do_cluster> --region us-central1 --project <id_do_projeto> 
```

Após a configuração do kubectl execute novamente o Terraform para instalar as aplicações

```shell
terraform apply -var="install_apps=true" 
```

### Acesso aos serviços

- `RabbitMQ`

```shell
kubectl port-forward -n rabbitmq svc/rabbitmq 15672 
```

- `Prometheus`

```shell
kubectl -n prometheus port-forward svc/kube-prometheus-prometheus 9090 
```

- `Grafana`

Recuperar a credencial gerada automaticamente.

```shell
echo "user:" $(kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-user}" | base64 --decode) "\npassword:"$(kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode) 
``

```shell
kubectl -n grafana port-forward svc/grafana 3000:80  
```

- `Dashboard k8s`

Recuperar o token do k8s gerada automaticamente.

```shell
gcloud config config-helper --format=json | jq -r '.credential.access_token'
```

Relizei o proxy usando o seguinte comando:

```shell
kubectl proxy
```

Acessa a seguinte URL:

```text
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:https/proxy/#/login 
```

## Destruir o laboratório

Para remover tudo basta executar o `terraform destroy` e remover os discos do RabbitMQ na Google Cloud.
