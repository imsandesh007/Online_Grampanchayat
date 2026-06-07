<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/admin-header.jsp" %>

<div class="row mb-4 align-items-center">
    <div class="col">
        <h3 class="fw-bold text-success"><i class="fas fa-comment-dots me-2"></i>Complaints Management</h3>
    </div>
    <div class="col-auto">
        <a href="?filter=PENDING" class="btn btn-sm btn-warning me-1">Pending</a>
        <a href="?filter=IN_PROGRESS" class="btn btn-sm btn-info me-1">In Progress</a>
        <a href="?filter=RESOLVED" class="btn btn-sm btn-success me-1">Resolved</a>
        <a href="?" class="btn btn-sm btn-outline-secondary">All</a>
    </div>
</div>

<div class="card border-0 shadow-sm rounded-4">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-success">
                    <tr><th>#</th><th>Citizen</th><th>Category</th><th>Subject</th><th>Location</th><th>Filed Date</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                <c:forEach var="c" items="${complaints}" varStatus="s">
                    <tr>
                        <td>${s.count}</td>
                        <td>${c.citizenName}</td>
                        <td><span class="badge bg-secondary">${c.category}</span></td>
                        <td>${c.subject}</td>
                        <td>${c.location}</td>
                        <td>${c.filedDate}</td>
                        <td>
                            <span class="badge ${c.status == 'RESOLVED' ? 'bg-success' : c.status == 'REJECTED' ? 'bg-danger' : c.status == 'IN_PROGRESS' ? 'bg-info' : 'bg-warning'}">${c.status}</span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-outline-primary" onclick="updateComplaint(${c.id})"><i class="fas fa-edit"></i></button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty complaints}"><tr><td colspan="8" class="text-center text-muted py-4">No complaints found.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content rounded-4">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-edit me-2"></i>Update Complaint Status</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/complaints" method="post">
                <div class="modal-body">
                    <input type="hidden" name="id" id="complaintId">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Status *</label>
                        <select name="status" class="form-select" required>
                            <option value="IN_PROGRESS">In Progress</option>
                            <option value="RESOLVED">Resolved</option>
                            <option value="REJECTED">Rejected</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Remarks</label>
                        <textarea name="remarks" class="form-control" rows="3" placeholder="Enter action taken..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success"><i class="fas fa-save me-2"></i>Update</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function updateComplaint(id) {
    document.getElementById('complaintId').value = id;
    new bootstrap.Modal(document.getElementById('updateModal')).show();
}
</script>

<%@ include file="../common/footer.jsp" %>
