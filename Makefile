
# setup will run a targetted apply of terraform resources in lon and nyc to make the demo quicker
setup:
	cd terraform && terraform init
	cd terraform && terraform apply -target civo_network.network -auto-approve
	cd terraform && terraform apply -target civo_firewall.cluster-firewall -auto-approve
	cd terraform && terraform apply -target civo_firewall.database-firewall -auto-approve

destroy:
	cd terraform && terraform destroy -auto-approve

step1:
	clear
	@echo "Terraform Provider"
	@echo
	cat terraform/provider.tf
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step2:
	clear
	@echo "Create the cluster"
	@echo
	cd terraform && terraform apply -target local_file.cluster-config -auto-approve
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step3:
	clear
	@echo "Show the kubeconfig"
	@echo
	cat terraform/kubeconfig
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step4:
	clear
	@echo "Get the nodes in the cluster"
	@echo
	KUBECONFIG=terraform/kubeconfig kubectl get nodes
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step5:
	clear
	@echo "Show the database terraform"
	@echo
	cat terraform/civo-database.tf
	recho
	@read -n 1 -s -p "Press any key to continue..."

step6:
	clear
	@echo "Create the database"
	@echo
	cd terraform/lon && terraform apply -target civo_database.database -auto-approve
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step7:
	clear
	@echo "Apply the rest of the config"
	@echo
	cd terraform/nyc && terraform apply -auto-approve
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step8:
	clear
	@echo "Show the secret in the cluster with the database details"
	@echo
	KUBECONFIG=terraform/lon/kubeconfig kubectl get secret -n default database-access -o json | jq '.data'
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# watch all pods in london
watchLondon:
	kubectl --kubeconfig=terraform/lon/kubeconfig get pods --all-namespaces -w


demo: step1 step2 step3 step4 step5 step6 step7 step8 

.PHONY: demo destroy steup step1 step2 step3 step4 step5 step6 step7 step8 

