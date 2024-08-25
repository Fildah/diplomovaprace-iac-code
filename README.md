# Diplomová práce Infrastruktura jako kód v cloudovém prostředí

### Autor: Filip Hanš

---

Každá služba je umístěna v samostatném adresáři.

K spuštění kódu je potřeba minimální verze Terraform 1.0.0 plně otestováno bylo na verzi 1.9.3. Pro komunikaci s Azure je potřeba provider azurerm 3.114.0 a být přihlášený do Azure pomocí Azure CLI.

Služby vyžadují vyplnění definicí nabízených proměnných. V případě nevyplnění bufou použity defaultní hodnoty.

Pro přípravu k nasazení služby je doporučeno použít exekuční plány: `terraform plan`

Pro finální nasazení použijte: `terraform apply`

Pro zrušení vytvořené infrastruktury použijte: `terraform destroy`

---

Pro další vývoj je možné využít připravené definice vývojového kontejneru pro Visual Studio Code, které obsahuje všechny potřebné součásti.
