---
concept: Authentication System
aliases: [Django Auth, User Authentication, django.contrib.auth]
tags: [dev, django]
created: 2026-08-09
updated: 2026-08-09
---

## Formal Definition

Django's Authentication System (`django.contrib.auth`) provides a complete user management framework including the `User` model (or custom user model), password hashing (PBKDF2 by default), session-based authentication, login/logout views, permission system (model-level and object-level), groups, and decorators/mixins for access control.

## Explanation

The auth system solves the problem of securely managing user identity, credentials, and access control in web applications. It handles user registration, login, logout, password reset/change, session management, and authorization through permissions and groups. The system is built on a swappable `User` model (default: `AbstractUser`), allowing customization while maintaining compatibility with admin, forms, and third-party packages.

## How It Works

1. **User model** — `AUTH_USER_MODEL` points to user class (default `auth.User` or custom)
2. **Password hashing** — `set_password()` uses PBKDF2+SHA256; `check_password()` verifies
3. **Login flow** — `authenticate(username, password)` → `login(request, user)` → sets session
4. **Session storage** — User ID stored in session; `request.user` populated by `AuthenticationMiddleware`
5. **Permission checks** — `user.has_perm('app.action_model')` or `@permission_required` decorator
6. **Groups** — Users inherit permissions from groups; `user.groups.add(group)`

## Visual Explanation

```dot
digraph auth_system {
  rankdir=TB;
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=10];

  UserModel [label="User Model\nAbstractUser / Custom\n(username, email, password)" fillcolor="#ffe5cc"];
  PasswordHash [label="PBKDF2+SHA256\nset_password() / check_password()"];
  Authenticate [label="authenticate()\n→ User or None"];
  Login [label="login(request, user)\n→ Session['_auth_user_id']"];
  Middleware [label="AuthenticationMiddleware\nrequest.user = LazyUser()"];
  Permissions [label="user.has_perm()\nuser.has_perms()\n@permission_required"];
  Groups [label="Groups\npermissions inherited"];

  UserModel -> PasswordHash [label="1. Store/verify"];
  UserModel -> Authenticate [label="2. Credentials"];
  Authenticate -> Login [label="3. Success"];
  Login -> Middleware [label="4. Session set"];
  Middleware -> Permissions [label="5. request.user"];
  UserModel -> Groups [label="6. Membership"];
  Groups -> Permissions [label="7. Inherited perms"];
}
```

## Semantic Network

```dot
graph semantic_auth_system {
  layout=neato;
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled];
  edge [fontname="Helvetica" fontsize=9];

  THIS [label="Authentication\nSystem" fillcolor="#ffd700" fontsize=13 style="filled,bold"];

  PRE1 [label="User Model\n(AbstractUser)" fillcolor="#cce5ff"];
  PRE2 [label="Session\nFramework" fillcolor="#cce5ff"];
  PRE3 [label="Password\nHashers" fillcolor="#cce5ff"];
  PRE4 [label="Permissions\nFramework" fillcolor="#cce5ff"];

  OUT1 [label="Login/Logout\nViews" fillcolor="#d4edda"];
  OUT2 [label="Password\nReset/Change" fillcolor="#d4edda"];
  OUT3 [label="Decorators\n/@login_required" fillcolor="#d4edda"];
  OUT4 [label="Custom User\nModel" fillcolor="#d4edda"];
  OUT5 [label="DRF\nAuthentication" fillcolor="#d4edda"];

  CON1 [label="Flask-Login\n(Extension)" fillcolor="#ffe5cc"];
  CON2 [label="FastAPI\nDependencies" fillcolor="#ffe5cc"];
  CON3 [label="NextAuth.js\n(Client-side)" fillcolor="#ffe5cc"];

  REL1 [label="CSRF\nProtection" fillcolor="#f0f0f0"];
  REL2 [label="Admin\nPanel" fillcolor="#f0f0f0"];

  THIS -- PRE1 [label="built from" style=dashed];
  THIS -- PRE2 [label="built from" style=dashed];
  THIS -- PRE3 [label="built from" style=dashed];
  THIS -- PRE4 [label="built from" style=dashed];
  THIS -- OUT1 [label="builds into"];
  THIS -- OUT2 [label="builds into"];
  THIS -- OUT3 [label="builds into"];
  THIS -- OUT4 [label="builds into"];
  THIS -- OUT5 [label="builds into"];
  THIS -- CON1 [label="contrasts with" style=dotted];
  THIS -- CON2 [label="contrasts with" style=dotted];
  THIS -- CON3 [label="contrasts with" style=dotted];
  THIS -- REL1 [label="related"];
  THIS -- REL2 [label="related"];
}
```

## Key Properties

- **Swappable User model**: `AUTH_USER_MODEL = 'myapp.CustomUser'` — must set before first migration
- **Password hashers**: `PASSWORD_HASHERS` setting; PBKDF2 default; supports bcrypt, argon2, scrypt
- **Session backend**: Database, cache, file, or signed cookies; `SESSION_ENGINE` setting
- **Permissions**: `add`, `change`, `delete`, `view` auto-created per model; custom via `Meta.permissions`
- **Object-level permissions**: Not built-in; use `django-guardian` or custom `has_perm` override
- **Auth backends**: `AUTHENTICATION_BACKENDS` — `ModelBackend` default; can add LDAP, OAuth, etc.

## Connections

- Built from: [[user-model|User Model]] — Core identity representation
- Built from: [[session-framework|Session Framework]] — Persists login state
- Built from: [[password-hashers|Password Hashers]] — Secure credential storage
- Built from: [[permissions-framework|Permissions Framework]] — Authorization layer
- Builds into: [[login-logout-views|Login/Logout Views]] — Built-in auth views
- Builds into: [[password-reset|Password Reset/Change]] — Token-based email flow
- Builds into: [[auth-decorators|Auth Decorators]] — `@login_required`, `@permission_required`
- Builds into: [[custom-user-model|Custom User Model]] — Extend/replace default User
- Builds into: [[drf-authentication|DRF Authentication]] — Token, JWT, Session auth for APIs
- Contrasts with: [[flask-login|Flask-Login]] — Extension, user loader callback, less integrated
- Contrasts with: [[fastapi-auth|FastAPI Dependencies]] — Dependency injection, no built-in User model
- Related: [[csrf-protection|CSRF Protection]] — Login forms need CSRF token
- Related: [[admin-panel|Admin Panel]] — Uses auth for admin access control

## Edge Cases & Gotchas

- **Custom user model timing**: Must set `AUTH_USER_MODEL` before *any* migrations; changing later is extremely difficult
- **`username` vs `email`**: Default User requires unique username; email not unique by default — customize for email-as-username
- **Session fixation**: `login()` rotates session key; `SESSION_COOKIE_HTTPONLY`, `SECURE` should be True in prod
- **Permission caching**: `user.get_all_permissions()` caches; `user.has_perm()` uses cache; `user = User.objects.get(...)` refreshes
- **`is_active` flag**: Inactive users can't login; `authenticate()` returns None for inactive users