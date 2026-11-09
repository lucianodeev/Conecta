# CONECTA — Implementação de produção (pendente de base de dados exclusiva)

## Requisitos de segurança
- Autenticação de administradores com MFA; nunca guardar uma palavra-passe fixa no HTML.
- Banco exclusivo para o CONECTA, não reutilizar bancos de outros projetos.
- Tabelas orders, experiences, share_links, audit_events.
- Tokens aleatórios gerados no servidor; persistir SHA-256, não token em texto claro.
- Validar validade e revogação no servidor em cada acesso.
- Não aceitar dados de encomenda sem limites de tamanho, proteção contra spam e consentimento informado.
- Política de privacidade, retenção, eliminação e pedido de acesso.
- Backup e recuperação verificados.
- Testes de autorização, expiração, revogação, concorrência, XSS e acesso indevido.
- HTTPS, cabeçalhos de segurança, CSP e limites de requisições.
- Não ligar Stripe ou pagamentos até autorização expressa e validação fiscal.

## Estado de implementação
- Experiências Mini, Magic e Premium: demonstração pública.
- Links individuais: demonstração, sem encriptação ou revogação.
- Painel de gestão: demonstração local, sem login.
- Base de dados, backend, autenticação e links seguros: NÃO IMPLEMENTADOS.

## Sequência de implementação
1. Escolher organização e criar projeto Supabase exclusivo ou contratar base de dados durável.
2. Criar esquema e políticas RLS, rever com consultor de segurança.
3. Implementar autenticação administrativa e API com validação.
4. Implementar links com token e revogação no servidor.
5. Integrar frontend, fazer testes automatizados e manuais.
6. Ativar pedidos reais apenas após revisão de privacidade e conformidade.
