az acr create   --resource-group rg-flask-demo   --name acrflaskdemo123   --sku Basic
az group create --name rg-flask-demo --location westeurope
az acr create   --resource-group rg-flask-demo   --name acrflaskdemo123   --sku Basic
unzip flask-app.zip
cd flask-app
ls -ltra
cd unzip flask-app.zip
cd flask-app
az acr build   --registry acrflaskdemo123   --image flask-app:v1 .
mv dockerfile Dockerfile
ls -ltra
az acr build   --registry acrflaskdemo123   --image flask-app:v1 .
az appservice plan create   --name flaskPlan   --resource-group rg-flask-demo   --sku B1   --is-linux
az webapp create   --resource-group rg-flask-demo   --plan flaskPlan   --name flask-demo-xoan   --deployment-container-image-name acrflaskdemo123.azurecr.io/flask-app:v1
az webapp config container set   --name flask-demo-xoan   --resource-group rg-flask-demo   --docker-custom-image-name acrflaskdemo123.azurecr.io/flask-app:v1   --docker-registry-server-url https://acrflaskdemo123.azurecr.io
az webapp config container set   --name flask-demo-xoan   --resource-group rg-flask-demo   --docker-registry-server-user $(az acr credential show --name acrflaskdemo123 --query username -o tsv)   --docker-registry-server-password $(az acr credential show --name acrflaskdemo123 --query passwords[0].value -o tsv)
az acr update -n acrflaskdemo123 --admin-enabled true
az webapp config container set   --name flask-demo-xoan   --resource-group rg-flask-demo   --docker-registry-server-url https://acrflaskdemo123.azurecr.io   --docker-custom-image-name acrflaskdemo123.azurecr.io/your-image-name:tag   --docker-registry-server-user $(az acr credential show --name acrflaskdemo123 --query username -o tsv)   --docker-registry-server-password $(az acr credential show --name acrflaskdemo123 --query passwords[0].value -o tsv)
az webapp show   --name flask-demo-xoan   --resource-group rg-flask-demo   --query defaultHostName   --output tsv
az webapp log tail   --name flask-demo-xoan   --resource-group rg-flask-demo
az webapp config appsettings set   --resource-group rg-flask-demo   --name flask-demo-xoan   --settings WEBSITES_PORT=5000
az webapp config container set   --name flask-demo-xoan   --resource-group rg-flask-demo   --docker-registry-server-url https://acrflaskdemo123.azurecr.io   --docker-custom-image-name acrflaskdemo123.azurecr.io/flask-app:v1   --docker-registry-server-user $(az acr credential show --name acrflaskdemo123 --query username -o tsv)   --docker-registry-server-password $(az acr credential show --name acrflaskdemo123 --query passwords[0].value -o tsv)
az webapp log tail   --name flask-demo-xoan   --resource-group rg-flask-demo
az webapp config appsettings set   --resource-group rg-flask-demo   --name flask-demo-xoan   --settings WEBSITES_PORT=5000
az webapp show   --name flask-demo-xoan   --resource-group rg-flask-demo   --query defaultHostName   --output tsv
git init
git add .
git commit -m "Primer commit desde Azure Cloud Shell"
git config --global user.email "xoanabella@gmail.com"
git add .
git commit -m "Primer commit desde Azure Cloud Shell"
git remote add origin https://github.com/xoanabella/flask-azure-cicd.git
git push -u origin master
git init
git config --global user.name "Xoan Abella"
git config --global user.email "xoanabella@gmail.com"
