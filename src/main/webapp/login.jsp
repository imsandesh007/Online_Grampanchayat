<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Gram Panchayat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="auth-bg">
<div class="container-fluid min-vh-100 d-flex align-items-center justify-content-center">
    <div class="row w-100 justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-header text-center py-4 bg-success text-white rounded-top-4">
                    <i class="fas fa-landmark fa-2x mb-2"></i>
                    <h4 class="mb-0 fw-bold">Gram Panchayat</h4>
                    <small>e-Governance Portal</small>
                </div>
                <div class="card-body p-4">
                    <h5 class="text-center mb-4 text-muted">Sign In to Your Account</h5>

                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i><%= request.getAttribute("error") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>
                    <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i><%= request.getAttribute("success") %>
                    </div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/login" method="post" onsubmit="return validateLogin()">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope text-success"></i></span>
                                <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-semibold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock text-success"></i></span>
                                <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
                                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword()">
                                    <i class="fas fa-eye" id="eyeIcon"></i>
                                </button>
                            </div>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i>Login
                            </button>
                        </div>
                    </form>
                    <hr>
                    <div class="text-center">
                        <span class="text-muted">New citizen? </span>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="text-success fw-semibold">Register Here</a>
                    </div>
                    <div class="mt-3 p-2 bg-light rounded">
                        <small class="text-muted"><strong>Admin Login:</strong> admin@gp.gov.in / admin123</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function togglePassword() {
    const pwd = document.getElementById('password');
    const icon = document.getElementById('eyeIcon');
    pwd.type = pwd.type === 'password' ? 'text' : 'password';
    icon.className = pwd.type === 'password' ? 'fas fa-eye' : 'fas fa-eye-slash';
}
function validateLogin() {
    const email = document.querySelector('input[name="email"]').value.trim();
    const password = document.querySelector('input[name="password"]').value.trim();
    if (!email || !password) { alert('Please fill all fields.'); return false; }
    return true;
}
</script>
</body>
</html>
