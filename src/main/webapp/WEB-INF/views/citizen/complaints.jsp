<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/citizen-header.jsp" %>

<div class="row mb-4">
    <div class="col"><h3 class="fw-bold text-danger"><i class="fas fa-comment-dots me-2"></i>Complaints</h3></div>
</div>

<c:if test="${param.msg == 'success'}">
    <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle me-2"></i>Complaint filed successfully! We will look into it.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row g-4">
    <!-- File Complaint -->
    <div class="col-md-5">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-danger text-white rounded-top-4 py-3">
                <h6 class="mb-0 fw-bold"><i class="fas fa-plus-circle me-2"></i>File a New Complaint</h6>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/citizen/complaints" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Category *</label>
                        <select name="category" class="form-select" required>
                            <option value="">-- Select Category --</option>
                            <option value="ROAD">Road Issue</option>
                            <option value="WATER">Water Supply</option>
                            <option value="ELECTRICITY">Electricity</option>
                            <option value="SANITATION">Sanitation</option>
                            <option value="OTHER">Other</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Subject *</label>
                        <input type="text" name="subject" class="form-control" placeholder="Brief subject of complaint" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Description *</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Describe the issue in detail..." required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Location</label>
                        <input type="text" name="location" class="form-control" placeholder="Street, Ward, Area">
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-danger"><i class="fas fa-paper-plane me-2"></i>Submit Complaint</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- My Complaints -->
    <div class="col-md-7">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h6 class="fw-bold"><i class="fas fa-list me-2"></i>My Complaints</h6>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr><th>Subject</th><th>Category</th><th>Filed Date</th><th>Status</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="c" items="${complaints}">
                            <tr>
                                <td>
                                    <strong>${c.subject}</strong>
                                    <small class="d-block text-muted">${c.location}</small>
                                    <c:if test="${not empty c.adminRemarks}">
                                        <small class="d-block text-info"><i class="fas fa-reply me-1"></i>${c.adminRemarks}</small>
                                    </c:if>
                                </td>
                                <td><span class="badge bg-secondary">${c.category}</span></td>
                                <td><small>${c.filedDate}</small></td>
                                <td>
                                    <span class="badge
                                        ${c.status == 'RESOLVED' ? 'bg-success' :
                                          c.status == 'IN_PROGRESS' ? 'bg-info' :
                                          c.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">
                                        ${c.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty complaints}">
                            <tr><td colspan="4" class="text-center text-muted py-4">No complaints filed yet.</td></tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
