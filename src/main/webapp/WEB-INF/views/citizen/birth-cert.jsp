<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/citizen-header.jsp" %>

<div class="row mb-4">
    <div class="col"><h3 class="fw-bold text-primary"><i class="fas fa-baby me-2"></i>Birth Certificate Application</h3></div>
</div>

<c:if test="${param.msg == 'success'}">
    <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle me-2"></i>Birth certificate application submitted successfully! We will process it shortly.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row g-4">
    <!-- Application Form -->
    <div class="col-md-6">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-primary text-white rounded-top-4 py-3">
                <h6 class="mb-0 fw-bold"><i class="fas fa-plus-circle me-2"></i>Apply for Birth Certificate</h6>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/citizen/certificates" method="post">
                    <input type="hidden" name="type" value="birth">
                    <div class="mb-3"><label class="form-label fw-semibold">Child's Full Name *</label>
                        <input type="text" name="childName" class="form-control" required></div>
                    <div class="mb-3"><label class="form-label fw-semibold">Date of Birth *</label>
                        <input type="date" name="dateOfBirth" class="form-control" required></div>
                    <div class="mb-3"><label class="form-label fw-semibold">Place of Birth *</label>
                        <input type="text" name="placeOfBirth" class="form-control" required></div>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="form-label fw-semibold">Father's Name *</label>
                            <input type="text" name="fatherName" class="form-control" required></div>
                        <div class="col-md-6 mb-3"><label class="form-label fw-semibold">Mother's Name *</label>
                            <input type="text" name="motherName" class="form-control" required></div>
                        <div class="col-md-6 mb-3"><label class="form-label fw-semibold">Father's Occupation</label>
                            <input type="text" name="fatherOccupation" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="form-label fw-semibold">Mother's Occupation</label>
                            <input type="text" name="motherOccupation" class="form-control"></div>
                    </div>
                    <div class="mb-3"><label class="form-label fw-semibold">Residential Address *</label>
                        <textarea name="address" class="form-control" rows="2" required></textarea></div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane me-2"></i>Submit Application</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- My Applications -->
    <div class="col-md-6">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h6 class="fw-bold"><i class="fas fa-list me-2"></i>My Birth Certificate Applications</h6>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light"><tr><th>Child Name</th><th>DOB</th><th>Status</th></tr></thead>
                        <tbody>
                        <c:forEach var="bc" items="${bcList}">
                            <tr>
                                <td>${bc.childName}</td>
                                <td>${bc.dateOfBirth}</td>
                                <td><span class="badge ${bc.status == 'APPROVED' ? 'bg-success' : bc.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">${bc.status}</span>
                                    <c:if test="${bc.adminRemarks != null && bc.adminRemarks != ''}">
                                        <small class="d-block text-muted">${bc.adminRemarks}</small>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bcList}"><tr><td colspan="3" class="text-center text-muted py-3">No applications yet.</td></tr></c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
