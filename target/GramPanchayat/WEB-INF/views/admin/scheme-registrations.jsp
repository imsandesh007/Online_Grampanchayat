<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/admin-header.jsp" %>

<div class="row mb-4 align-items-center">
    <div class="col">
        <h3 class="fw-bold text-success"><i class="fas fa-list-check me-2"></i>Scheme Registrations</h3>
    </div>
    <div class="col-auto">
        <a href="${pageContext.request.contextPath}/admin/schemes" class="btn btn-outline-secondary"><i class="fas fa-arrow-left me-2"></i>Back to Schemes</a>
    </div>
</div>

<div class="card border-0 shadow-sm rounded-4">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-success">
                    <tr><th>#</th><th>Citizen</th><th>Scheme</th><th>Income</th><th>Family</th><th>Applied</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                <c:forEach var="r" items="${registrations}" varStatus="s">
                    <tr>
                        <td>${s.count}</td>
                        <td>${r.citizenName}</td>
                        <td>${r.schemeName}</td>
                        <td>₹${r.annualIncome}</td>
                        <td>${r.familyMembers}</td>
                        <td>${r.appliedDate}</td>
                        <td><span class="badge ${r.status == 'APPROVED' ? 'bg-success' : r.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">${r.status}</span></td>
                        <td>
                            <c:if test="${r.status == 'PENDING'}">
                                <button class="btn btn-sm btn-outline-success" onclick="reviewReg(${r.id}, 'approve')"><i class="fas fa-check"></i></button>
                                <button class="btn btn-sm btn-outline-danger" onclick="reviewReg(${r.id}, 'reject')"><i class="fas fa-times"></i></button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty registrations}"><tr><td colspan="8" class="text-center text-muted py-4">No registrations found.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Review Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content rounded-4">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Review Registration</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/schemes" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" id="regAction">
                    <input type="hidden" name="regId" id="regId">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Remarks</label>
                        <textarea name="remarks" class="form-control" rows="3" placeholder="Enter remarks..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success" id="regSubmitBtn">Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function reviewReg(id, action) {
    document.getElementById('regId').value = id;
    document.getElementById('regAction').value = action;
    document.getElementById('regSubmitBtn').textContent = action === 'approve' ? 'Approve' : 'Reject';
    document.getElementById('regSubmitBtn').className = action === 'approve' ? 'btn btn-success' : 'btn btn-danger';
    new bootstrap.Modal(document.getElementById('reviewModal')).show();
}
</script>

<%@ include file="../common/footer.jsp" %>
