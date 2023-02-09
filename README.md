# final-task-gcp

## Description
> It is a simple infrastructure which have 1 vpc and 2 subnets. First subnet is called management subnet which contains private vm and nat gateway. Second subnet is called restricted subnet which contains private standard GKE cluster and private control plane. Only management subnet can connect to the cluster. Service accounts are created and attached to vm and cluster with least privillage. Python application with redis are deployed and their images are pushed to GCR. Deployment is exposed to public internet with public http load balancer.

## Tools
  - Google Cloud Platform (GCP)
  - Terragorm
  - Docker
  - Kubernetes

## Run Project 
1. Clone the project
```bash  
   git clone https://github.com/salmarefaie/final-task-gcp.git
```

2. Run infrastrucrure using terraform
```bash      
   gcloud auth application-default login
   cd Terraform
   terraform init
   terraform plan
   terraform apply
```
3. Downlooad python application from this repo
```bash  
   https://github.com/atefhares/DevOps-Challenge-Demo-Code
```

4. Make docker configuration
```bash  
   sudo usermod -a -G docker ${USER}
   gcloud auth configure-docker
``` 

5. Build Docker file for python application to create image then push it to GCR
```bash  
   cd Docker Image
   docker build -t project-python-app .
   docker tag project-python-app gcr.io/mineral-order-375711/project-python-app
   docker push gcr.io/mineral-order-375711/project-python-app:latest
```
![Screenshot from 2023-02-09 23-23-09](https://user-images.githubusercontent.com/76884936/217942752-c3481843-5233-4a5f-9e44-a7430ea900fa.png)

6. Pull redis image from docker hub then push it to GCR
```bash  
   docker pull redis
   docker tag redis gcr.io/mineral-order-375711/project-redis
   docker push gcr.io/mineral-order-375711/project-redis:latest
```
![Screenshot from 2023-02-09 23-23-36](https://user-images.githubusercontent.com/76884936/217942382-4fa616f6-f72d-4c96-8a72-e8078bc931d4.png)

7. Connect to vm by ssh

![Screenshot from 2023-02-09 17-17-22](https://user-images.githubusercontent.com/76884936/217854385-52516481-9cd0-458d-bb9e-a7d0abc6b5df.png)

8. Connect to cluster from vm and install kubectl and auth plugins 
```bash  
   gcloud container clusters get-credentials gke --zone us-central1-a --project mineral-order-375711
   sudo apt-get install kubectl
   sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
```
![Screenshot from 2023-02-09 17-16-02](https://user-images.githubusercontent.com/76884936/217854333-ef6535d8-a25a-486e-9f48-e5224cc2e50d.png)

9. Upload yaml files which exists in deployment folder in repo or you can make files in vm by using vi command
   - redis-deployment.yaml: deployment of redis image
   - clusterIP-service.yaml: service to make communication between redis and python application 
   - config-map.yaml: declares enviroments variables. Env variables can be declared also  in docker file but config map is better. 
   - python-deployment.yaml: deployment of python application image
   - loadBalancer-service.yaml: service to expose application from public
   
10. Apply yaml files 
```bash  
   kubectl apply -f redis-deployment.yaml
   kubectl apply -f clusterIP-service.yaml
   kubectl apply -f config-map.yaml
   kubectl apply -f python-deployment.yaml
   kubectl apply -f loadBalancer-service.yaml
   kubectl get all
```
![Screenshot from 2023-02-09 23-43-31](https://user-images.githubusercontent.com/76884936/217946287-7fbe9cc2-2830-4a7b-8e00-f33b3b9816f1.png)
![Screenshot from 2023-02-09 23-46-02](https://user-images.githubusercontent.com/76884936/217946544-5fc26fae-807e-4243-896b-cbba5a776211.png)

11. expose application to public internet by load balancer ip 

![Screenshot from 2023-02-09 23-42-13](https://user-images.githubusercontent.com/76884936/217946182-41c473f1-76e3-4bf1-9a0d-bc6e5c52b830.png)
