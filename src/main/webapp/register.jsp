<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Gram Panchayat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="auth-bg">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-header text-center py-4 bg-success text-white rounded-top-4">
                    <i class="fas fa-user-plus fa-2x mb-2"></i>
                    <h4 class="mb-0 fw-bold">Citizen Registration</h4>
                    <small>Gram Panchayat e-Governance Portal</small>
                </div>
                <div class="card-body p-4">

                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger"><i class="fas fa-exclamation-circle me-2"></i><%= request.getAttribute("error") %></div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateRegister()">
                        <div class="row">
                            <div class="col-12 mb-3">
                                <label class="form-label fw-semibold">Full Name *</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user text-success"></i></span>
                                    <input type="text" name="fullName" class="form-control" placeholder="Enter your full name" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Email Address *</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-envelope text-success"></i></span>
                                    <input type="email" name="email" class="form-control" placeholder="Email" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Mobile Number *</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-phone text-success"></i></span>
                                    <input type="text" name="mobile" class="form-control" placeholder="10-digit mobile" maxlength="10" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Password *</label>
                                <input type="password" name="password" id="password" class="form-control" placeholder="Min 6 characters" required minlength="6">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Confirm Password *</label>
                                <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm password" required>
                            </div>
                            <div class="col-12 mb-4">
                                <label class="form-label fw-semibold">Address</label>
                                <textarea name="address" class="form-control" rows="2" placeholder="Village, Taluka, District"></textarea>
                            </div>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="fas fa-user-check me-2"></i>Register
                            </button>
                        </div>
                    </form>
                    <hr>
                    <div class="text-center">
                        <span class="text-muted">Already registered? </span>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="text-success fw-semibold">Login Here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function validateRegister() {
    const pwd = document.getElementById('password').value;
    const cpwd = document.getElementById('confirmPassword').value;
    const mobile = document.querySelector('input[name="mobile"]').value;
    if (pwd !== cpwd) { alert('Passwords do not match!'); return false; }
    if (!/^\d{10}$/.test(mobile)) { alert('Please enter a valid 10-digit mobile number.'); return false; }
    return true;
}
</script>
</body>
</html>
