-- Restrictions supplémentaires pour améliorer la sécurité

-- Limitation des ressources pour un utilisateur
ALTER PROFILE DEFAULT LIMIT
  FAILED_LOGIN_ATTEMPTS 5
  PASSWORD_LIFE_TIME 30;

-- Ajout d'une politique d'audit pour surveiller les connexions
AUDIT SESSION BY admin_user;
AUDIT SELECT TABLE, INSERT TABLE, UPDATE TABLE, DELETE TABLE BY manager_user;
AUDIT SELECT TABLE BY regular_user;

-- Verrouillage des comptes après plusieurs échecs de connexion
ALTER USER regular_user ACCOUNT LOCK;
