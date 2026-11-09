# CONECTA Surpresa — Etapa de gestão e privacidade

## Estado atual
- Site público estático com experiências Mini, Magic e Premium.
- Links individuais incluem conteúdo codificado no fragmento da URL (#s=...).
- O conteúdo não é encriptado, não expira e não tem controlo de acesso.
- Não há armazenamento de pedidos, autenticação, base de dados nem checkout.

## Requisitos antes de receber encomendas reais
1. Serviço de backend com HTTPS, autenticação de administrador e autorização por função.
2. Base de dados com pedidos, experiências, estados e expiração dos links.
3. Tokens aleatórios e não adivinháveis; guardar apenas hash do token no servidor.
4. Página de visualização que consulta o backend sem colocar mensagens na URL.
5. Opção de revogar links e definir data de expiração.
6. Política de retenção e eliminação de dados, privacidade e consentimentos adequados.
7. Proteção contra abuso, limites de pedidos e registos de auditoria sem mensagens pessoais.
8. Testes de ponta a ponta e revisão de segurança antes de disponibilizar o formulário público.

## Modelo de dados proposto
- orders: id, tier, status, created_at, expires_at
- experiences: id, order_id, occasion, recipient_name, sender_name, message, question, choice_a, choice_b, memory
- share_links: id, experience_id, token_hash, expires_at, revoked_at
- audit_events: id, action, object_id, timestamp

## Limites da versão atual
A demonstração não aceita pagamentos nem pedidos comerciais. Não enviar informação sensível por links gerados nesta versão.

## Próxima implementação
Criar backend e persistência com permissões verificadas, só depois substituir links baseados em fragmentos por links com tokens protegidos. Não ativar checkout até confirmação fiscal e comercial.
