<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/admin-header.jsp" %>

<div class="row mb-4 align-items-center">
    <div class="col">
        <h3 class="fw-bold text-success"><i class="fas fa-certificate me-2"></i>Certificate Applications</h3>
    </div>
</div>

<!-- Nav Tabs -->
<ul class="nav nav-tabs mb-4" id="certTabs">
    <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#birth"><i class="fas fa-baby me-2"></i>Birth Certificates</a></li>
    <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#death"><i class="fas fa-cross me-2"></i>Death Certificates</a></li>
</ul>

<div class="tab-content">
    <!-- Birth Certificates -->
    <div class="tab-pane fade show active" id="birth">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-success">
                            <tr>
                                <th>#</th><th>Applicant</th><th>Child Name</th><th>Date of Birth</th><th>Applied Date</th><th>Status</th><th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="bc" items="${birthList}" varStatus="s">
                            <tr>
                                <td>${s.count}</td>
                                <td>${bc.citizenName}</td>
                                <td>${bc.childName}</td>
                                <td>${bc.dateOfBirth}</td>
                                <td>${bc.appliedDate}</td>
                                <td><span class="badge ${bc.status == 'APPROVED' ? 'bg-success' : bc.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">${bc.status}</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" onclick="showApproval('birth', ${bc.id})">
                                        <i class="fas fa-eye me-1"></i>Review
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty birthList}"><tr><td colspan="7" class="text-center text-muted py-4">No birth certificate applications found.</td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Death Certificates -->
    <div class="tab-pane fade" id="death">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-secondary">
                            <tr>
                                <th>#</th><th>Applicant</th><th>Deceased Name</th><th>Date of Death</th><th>Applied Date</th><th>Status</th><th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="dc" items="${deathList}" varStatus="s">
                            <tr>
                                <td>${s.count}</td>
                                <td>${dc.citizenName}</td>
                                <td>${dc.deceasedName}</td>
                                <td>${dc.dateOfDeath}</td>
                                <td>${dc.appliedDate}</td>
                                <td><span class="badge ${dc.status == 'APPROVED' ? 'bg-success' : dc.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">${dc.status}</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" onclick="showApproval('death', ${dc.id})">
                                        <i class="fas fa-eye me-1"></i>Review
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty deathList}"><tr><td colspan="7" class="text-center text-muted py-4">No death certificate applications found.</td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Approval Modal -->
<div class="modal fade" id="approvalModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content rounded-4">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-check-circle me-2"></i>Review Application</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/certificates" method="post">
                <div class="modal-body">
                    <input type="hidden" name="type" id="certType">
                    <input type="hidden" name="id" id="certId">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Decision *</label>
                        <select name="status" class="form-select" required>
                            <option value="APPROVED">Approve</option>
                            <option value="REJECTED">Reject</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Remarks</label>
                        <textarea name="remarks" class="form-control" rows="3" placeholder="Enter remarks..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success"><i class="fas fa-save me-2"></i>Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function showApproval(type, id) {
    document.getElementById('certType').value = type;
    document.getElementById('certId').value = id;
    new bootstrap.Modal(document.getElementById('approvalModal')).show();
}
</script>

<%@ include file="../common/footer.jsp" %>
