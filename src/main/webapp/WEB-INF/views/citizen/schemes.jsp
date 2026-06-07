<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/citizen-header.jsp" %>

<div class="row mb-4">
    <div class="col"><h3 class="fw-bold text-success"><i class="fas fa-hand-holding-heart me-2"></i>Government Schemes</h3></div>
</div>

<c:if test="${param.msg == 'success'}">
    <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle me-2"></i>Scheme registration submitted successfully! Awaiting admin approval.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.msg == 'already'}">
    <div class="alert alert-warning alert-dismissible fade show">
        <i class="fas fa-exclamation-triangle me-2"></i>You have already registered for this scheme.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Available Schemes -->
<h5 class="fw-bold mb-3"><i class="fas fa-list me-2 text-success"></i>Available Schemes</h5>
<div class="row g-4 mb-5">
    <c:forEach var="s" items="${schemes}">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm rounded-4 h-100">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <h6 class="fw-bold text-success mb-0">${s.schemeName}</h6>
                        <span class="badge bg-success">Active</span>
                    </div>
                    <p class="text-muted small mb-2">${s.description}</p>
                    <div class="mb-1"><strong class="small">Eligibility:</strong> <span class="small text-muted">${s.eligibility}</span></div>
                    <div class="mb-2"><strong class="small">Benefits:</strong> <span class="small text-muted">${s.benefits}</span></div>
                    <div class="mb-3"><small class="text-danger"><i class="fas fa-calendar me-1"></i>Last Date: ${s.lastDate}</small></div>
                    <button class="btn btn-success btn-sm" onclick="openRegModal(${s.id}, '${s.schemeName}')">
                        <i class="fas fa-plus-circle me-2"></i>Register Now
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty schemes}"><div class="col-12"><p class="text-muted">No active schemes available at the moment.</p></div></c:if>
</div>

<!-- My Registrations -->
<h5 class="fw-bold mb-3"><i class="fas fa-clipboard-list me-2 text-primary"></i>My Scheme Registrations</h5>
<div class="card border-0 shadow-sm rounded-4">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-success">
                    <tr><th>#</th><th>Scheme Name</th><th>Annual Income</th><th>Family Members</th><th>Applied Date</th><th>Status</th></tr>
                </thead>
                <tbody>
                <c:forEach var="r" items="${myRegistrations}" varStatus="s">
                    <tr>
                        <td>${s.count}</td>
                        <td>${r.schemeName}</td>
                        <td>₹${r.annualIncome}</td>
                        <td>${r.familyMembers}</td>
                        <td>${r.appliedDate}</td>
                        <td>
                            <span class="badge ${r.status == 'APPROVED' ? 'bg-success' : r.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">${r.status}</span>
                            <c:if test="${not empty r.adminRemarks}">
                                <small class="d-block text-muted">${r.adminRemarks}</small>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty myRegistrations}"><tr><td colspan="6" class="text-center text-muted py-4">No registrations yet.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Registration Modal -->
<div class="modal fade" id="regModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content rounded-4">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-hand-holding-heart me-2"></i>Register for Scheme</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/citizen/schemes" method="post">
                <div class="modal-body">
                    <input type="hidden" name="schemeId" id="schemeId">
                    <p class="fw-semibold text-success" id="schemeName"></p>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Annual Family Income (₹) *</label>
                        <input type="number" name="annualIncome" class="form-control" placeholder="e.g. 120000" required min="0">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Occupation *</label>
                        <input type="text" name="occupation" class="form-control" placeholder="e.g. Farmer" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Number of Family Members *</label>
                        <input type="number" name="familyMembers" class="form-control" min="1" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Additional Remarks</label>
                        <textarea name="remarks" class="form-control" rows="2" placeholder="Any additional information..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success"><i class="fas fa-paper-plane me-2"></i>Submit Registration</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function openRegModal(id, name) {
    document.getElementById('schemeId').value = id;
    document.getElementById('schemeName').textContent = name;
    new bootstrap.Modal(document.getElementById('regModal')).show();
}
</script>

<%@ include file="../common/footer.jsp" %>
