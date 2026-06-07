<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/citizen-header.jsp" %>

<div class="row mb-4">
    <div class="col"><h3 class="fw-bold text-secondary"><i class="fas fa-cross me-2"></i>Death Certificate Application</h3></div>
</div>

<c:if test="${param.msg == 'success'}">
    <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle me-2"></i>Death certificate application submitted successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row g-4">
    <div class="col-md-6">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-secondary text-white rounded-top-4 py-3">
                <h6 class="mb-0 fw-bold"><i class="fas fa-plus-circle me-2"></i>Apply for Death Certificate</h6>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/citizen/certificates" method="post">
                    <input type="hidden" name="type" value="death">
                    <div class="mb-3"><label class="form-label fw-semibold">Deceased Person's Name *</label>
                        <input type="text" name="deceasedName" class="form-control" required></div>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="form-label fw-semibold">Date of Death *</label>
                            <input type="date" name="dateOfDeath" class="form-control" required></div>
                        <div class="col-md-6 mb-3"><label class="form-label fw-semibold">Age at Death *</label>
                            <input type="number" name="ageAtDeath" class="form-control" min="0" max="150" required></div>
                    </div>
                    <div class="mb-3"><label class="form-label fw-semibold">Place of Death *</label>
                        <input type="text" name="placeOfDeath" class="form-control" required></div>
                    <div class="mb-3"><label class="form-label fw-semibold">Cause of Death</label>
                        <input type="text" name="causeOfDeath" class="form-control"></div>
                    <div class="mb-3"><label class="form-label fw-semibold">Your Relation with Deceased *</label>
                        <select name="relation" class="form-select" required>
                            <option value="">-- Select Relation --</option>
                            <option>Son</option><option>Daughter</option><option>Spouse</option>
                            <option>Father</option><option>Mother</option><option>Brother</option>
                            <option>Sister</option><option>Other</option>
                        </select>
                    </div>
                    <div class="mb-3"><label class="form-label fw-semibold">Residential Address *</label>
                        <textarea name="address" class="form-control" rows="2" required></textarea></div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-secondary"><i class="fas fa-paper-plane me-2"></i>Submit Application</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h6 class="fw-bold"><i class="fas fa-list me-2"></i>My Death Certificate Applications</h6>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light"><tr><th>Deceased Name</th><th>Date of Death</th><th>Status</th></tr></thead>
                        <tbody>
                        <c:forEach var="dc" items="${dcList}">
                            <tr>
                                <td>${dc.deceasedName}</td>
                                <td>${dc.dateOfDeath}</td>
                                <td>
                                    <span class="badge ${dc.status == 'APPROVED' ? 'bg-success' : dc.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">${dc.status}</span>
                                    <c:if test="${not empty dc.adminRemarks}">
                                        <small class="d-block text-muted">${dc.adminRemarks}</small>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty dcList}"><tr><td colspan="3" class="text-center text-muted py-3">No applications yet.</td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
