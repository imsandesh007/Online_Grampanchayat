<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../common/admin-header.jsp" %>

<div class="row mb-4">
    <div class="col-12">
        <h3 class="fw-bold text-success"><i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard</h3>
        <p class="text-muted">Welcome back, <strong>${sessionScope.userName}</strong>! Here's your system overview.</p>
    </div>
</div>

<!-- Stats Cards -->
<div class="row g-4 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="card stat-card border-0 shadow-sm rounded-4 bg-primary text-white">
            <div class="card-body d-flex align-items-center justify-content-between p-4">
                <div>
                    <div class="fs-1 fw-bold">${totalCitizens}</div>
                    <div class="opacity-75">Total Citizens</div>
                </div>
                <i class="fas fa-users fa-3x opacity-50"></i>
            </div>
            <div class="card-footer bg-transparent border-0 pb-3">
                <a href="${pageContext.request.contextPath}/admin/users" class="text-white text-decoration-none small"><i class="fas fa-arrow-right me-1"></i>View All</a>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="card stat-card border-0 shadow-sm rounded-4 bg-warning text-white">
            <div class="card-body d-flex align-items-center justify-content-between p-4">
                <div>
                    <div class="fs-1 fw-bold">${pendingBC + pendingDC}</div>
                    <div class="opacity-75">Pending Certificates</div>
                </div>
                <i class="fas fa-file-alt fa-3x opacity-50"></i>
            </div>
            <div class="card-footer bg-transparent border-0 pb-3">
                <a href="${pageContext.request.contextPath}/admin/certificates" class="text-white text-decoration-none small"><i class="fas fa-arrow-right me-1"></i>Review Now</a>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="card stat-card border-0 shadow-sm rounded-4 bg-danger text-white">
            <div class="card-body d-flex align-items-center justify-content-between p-4">
                <div>
                    <div class="fs-1 fw-bold">${pendingComplaints}</div>
                    <div class="opacity-75">Pending Complaints</div>
                </div>
                <i class="fas fa-exclamation-circle fa-3x opacity-50"></i>
            </div>
            <div class="card-footer bg-transparent border-0 pb-3">
                <a href="${pageContext.request.contextPath}/admin/complaints" class="text-white text-decoration-none small"><i class="fas fa-arrow-right me-1"></i>Resolve Now</a>
            </div>
        </div>
    </div>
    <div class="col-xl-3 col-md-6">
        <div class="card stat-card border-0 shadow-sm rounded-4 bg-success text-white">
            <div class="card-body d-flex align-items-center justify-content-between p-4">
                <div>
                    <div class="fs-1 fw-bold">${activeSchemes}</div>
                    <div class="opacity-75">Active Schemes</div>
                </div>
                <i class="fas fa-hand-holding-heart fa-3x opacity-50"></i>
            </div>
            <div class="card-footer bg-transparent border-0 pb-3">
                <a href="${pageContext.request.contextPath}/admin/schemes" class="text-white text-decoration-none small"><i class="fas fa-arrow-right me-1"></i>Manage</a>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="row g-4">
    <div class="col-md-6">
        <div class="card border-0 shadow-sm rounded-4 h-100">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h5 class="fw-bold"><i class="fas fa-bolt text-warning me-2"></i>Quick Actions</h5>
            </div>
            <div class="card-body px-4 pb-4">
                <div class="d-grid gap-2">
                    <a href="${pageContext.request.contextPath}/admin/certificates" class="btn btn-outline-warning">
                        <i class="fas fa-certificate me-2"></i>Review Certificate Applications (${pendingBC + pendingDC} pending)
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/schemes?action=registrations" class="btn btn-outline-info">
                        <i class="fas fa-list-check me-2"></i>Review Scheme Registrations (${pendingSchemes} pending)
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/complaints" class="btn btn-outline-danger">
                        <i class="fas fa-comment-dots me-2"></i>View Complaints (${pendingComplaints} pending)
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/schemes?action=add" class="btn btn-outline-success">
                        <i class="fas fa-plus me-2"></i>Add New Scheme
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card border-0 shadow-sm rounded-4 h-100">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h5 class="fw-bold"><i class="fas fa-chart-pie text-success me-2"></i>System Summary</h5>
            </div>
            <div class="card-body px-4 pb-4">
                <table class="table table-borderless">
                    <tbody>
                        <tr><td><i class="fas fa-baby text-primary me-2"></i>Birth Cert. Pending</td><td><span class="badge bg-warning">${pendingBC}</span></td></tr>
                        <tr><td><i class="fas fa-cross text-secondary me-2"></i>Death Cert. Pending</td><td><span class="badge bg-warning">${pendingDC}</span></td></tr>
                        <tr><td><i class="fas fa-hand-holding-heart text-success me-2"></i>Scheme Registrations Pending</td><td><span class="badge bg-warning">${pendingSchemes}</span></td></tr>
                        <tr><td><i class="fas fa-check-circle text-success me-2"></i>Resolved Complaints</td><td><span class="badge bg-success">${resolvedComplaints}</span></td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
