# 🛠️ Five Community - Base Oficial

Seja bem-vindo à **base desenvolvida com excelência** pela equipe da **Five Community**.  
Este projeto foi criado com dedicação para oferecer uma estrutura sólida e eficiente para servidores FiveM.

---

## 👤 Desenvolvedores Responsáveis

- **BKVINI.OFC1**
- **VOLPHZ**

> **Orgulhosamente desenvolvida pela [Five Community](https://discord.gg/fivecommunity)**

---

## 🌐 Comunidade

📌 Junte-se ao nosso servidor no Discord para suporte, atualizações e novidades:  
🔗 **[https://discord.gg/fivecommunity](https://discord.gg/fivecommunity)**

---

## 📣 Importante

> **📢 Caso deseje repostar ou compartilhar esta base:**  
> Por favor, **mantenha os créditos dos criadores.**  
> Isso é fundamental para que possamos continuar contribuindo com a comunidade, oferecendo projetos gratuitos e de qualidade.  
> Seu apoio faz a diferença! 💙

---

## ⚙️ Framework — Baseado em vRPex (vRP Modificado)

Esta base utiliza o **vRPex**, uma versão **profundamente otimizada e modificada** do framework original **vRP**, trazendo mais **estabilidade**, **desempenho** e **flexibilidade** para servidores FiveM de grande porte.

### 🚀 Desempenho

- ✅ Estrutura robusta e otimizada  
- ✅ Excelente gerenciamento de recursos  
- ✅ Suporte para até **2.000 jogadores simultâneos**  
- ✅ Alta compatibilidade com scripts personalizados  
- ✅ Ideal para servidores RP de médio a grande porte

### 🔒 Estabilidade

- Sistema modular e escalável  
- Redução significativa de travamentos e gargalos  
- Integração facilitada com bancos de dados (MySQL, MariaDB)  
- Processamento assíncrono de eventos e dados  
- Monitoramento e controle de performance por resource

> ⚠️ O **vRPex** é uma versão **fortemente modificada** do **vRP original**.  
> Todas as melhorias foram aplicadas visando **melhor performance**, **segurança** e **suporte a grandes comunidades**.

---

## 🧰 Área de Instalação

Todas as nossas bases são compatíveis e **requerem o uso do banco de dados MariaDB**.  
Para instalar e configurar corretamente, siga o passo a passo abaixo ou acesse nosso site com tutoriais detalhados:

🔗 **Tutorial completo e básico:** [https://www.fivetutors.site/](https://www.fivetutors.site/)

---

### 📦 Processo de Configuração

#### 1️⃣ Instale o MariaDB
Siga o tutorial em vídeo no site acima. **Não defina senha** durante a instalação para facilitar a configuração inicial.

#### 2️⃣ Instale o Apache
Instale o Apache conforme mostrado no segundo vídeo.  
Verifique o funcionamento acessando: [http://localhost](http://localhost)

#### 3️⃣ Instale o HeidiSQL
Conecte-se ao MariaDB local usando o usuário `root` (sem senha).  
Essa ferramenta facilita a administração do banco de dados.

#### 4️⃣ Gere sua Chave CFX
Para exibir seu servidor na lista pública do FiveM:

- Acesse: [https://keymaster.fivem.net/register](https://keymaster.fivem.net/register)  
- Faça login com sua conta FiveM  
- Clique em **"Register new server"**  
- Preencha os dados e aceite os termos  
- Clique em **"Generate"** e salve sua chave

Adicione no `server.cfg` com:

```cfg
sv_licenseKey "SUA_CHAVE_CFX"
