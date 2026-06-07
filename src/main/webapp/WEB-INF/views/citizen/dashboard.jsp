<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/citizen-header.jsp" %>

<div class="row mb-4">
    <div class="col">
        <h3 class="fw-bold text-primary"><i class="fas fa-home me-2"></i>Citizen Dashboard</h3>
        <p class="text-muted">Welcome, <strong>${sessionScope.userName}</strong>! Manage your applications and services here.</p>
    </div>
</div>

<!-- Quick Service Cards -->
<div class="row g-4 mb-4">
    <div class="col-md-3">
        <div class="card border-0 shadow-sm rounded-4 text-center h-100 service-card">
            <div class="card-body py-4">
                <div class="service-icon bg-primary-subtle rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width:60px;height:60px">
                    <i class="fas fa-baby fa-lg text-primary"></i>
                </div>
                <h6 class="fw-bold">Birth Certificate</h6>
                <p class="text-muted small">Apply for birth registration</p>
                <a href="${pageContext.request.contextPath}/citizen/certificates?type=birth" class="btn btn-primary btn-sm">Apply Now</a>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card border-0 shadow-sm rounded-4 text-center h-100 service-card">
            <div class="card-body py-4">
                <div class="service-icon bg-secondary-subtle rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width:60px;height:60px">
                    <i class="fas fa-cross fa-lg text-secondary"></i>
                </div>
                <h6 class="fw-bold">Death Certificate</h6>
                <p class="text-muted small">Apply for death registration</p>
                <a href="${pageContext.request.contextPath}/citizen/certificates?type=death" class="btn btn-secondary btn-sm">Apply Now</a>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card border-0 shadow-sm rounded-4 text-center h-100 service-card">
            <div class="card-body py-4">
                <div class="service-icon bg-success-subtle rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width:60px;height:60px">
                    <i class="fas fa-hand-holding-heart fa-lg text-success"></i>
                </div>
                <h6 class="fw-bold">Govt Schemes</h6>
                <p class="text-muted small">Register for eligible schemes</p>
                <a href="${pageContext.request.contextPath}/citizen/schemes" class="btn btn-success btn-sm">View Schemes</a>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card border-0 shadow-sm rounded-4 text-center h-100 service-card">
            <div class="card-body py-4">
                <div class="service-icon bg-danger-subtle rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" style="width:60px;height:60px">
                    <i class="fas fa-comment-dots fa-lg text-danger"></i>
                </div>
                <h6 class="fw-bold">File Complaint</h6>
                <p class="text-muted small">Report issues to panchayat</p>
                <a href="${pageContext.request.contextPath}/citizen/complaints" class="btn btn-danger btn-sm">File Now</a>
            </div>
        </div>
    </div>
</div>

<!-- My Applications Summary -->
<div class="row g-4">
    <div class="col-md-6">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h5 class="fw-bold"><i class="fas fa-file-alt text-primary me-2"></i>My Certificate Applications</h5>
            </div>
            <div class="card-body px-4 pb-4">
                <h6 class="text-muted">Birth Certificates</h6>
                <c:forEach var="bc" items="${bcList}">
                    <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                        <span><i class="fas fa-baby text-primary me-2"></i>${bc.childName}</span>
                        <span class="badge ${bc.status == 'APPROVED' ? 'bg-success' : bc.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">${bc.status}</span>
                    </div>
                </c:forEach>
                <c:if test="${empty bcList}"><p class="text-muted small">No birth certificate applications yet.</p></c:if>

                <h6 class="text-muted mt-3">Death Certificates</h6>
                <c:forEach var="dc" items="${dcList}">
                    <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                        <span><i class="fas fa-cross text-secondary me-2"></i>${dc.deceasedName}</span>
                        <span class="badge ${dc.status == 'APPROVED' ? 'bg-success' : dc.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">${dc.status}</span>
                    </div>
                </c:forEach>
                <c:if test="${empty dcList}"><p class="text-muted small">No death certificate applications yet.</p></c:if>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h5 class="fw-bold"><i class="fas fa-hand-holding-heart text-success me-2"></i>My Scheme Registrations</h5>
            </div>
            <div class="card-body px-4 pb-4">
                <c:forEach var="r" items="${myRegistrations}">
                    <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                        <span>${r.schemeName}</span>
                        <span class="badge ${r.status == 'APPROVED' ? 'bg-success' : r.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">${r.status}</span>
                    </div>
                </c:forEach>
                <c:if test="${empty myRegistrations}"><p class="text-muted small">No scheme registrations yet.</p></c:if>
            </div>
        </div>
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h5 class="fw-bold"><i class="fas fa-comment-dots text-danger me-2"></i>My Complaints</h5>
            </div>
            <div class="card-body px-4 pb-4">
                <c:forEach var="c" items="${myComplaints}">
                    <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                        <span>${c.subject}</span>
                        <span class="badge ${c.status == 'RESOLVED' ? 'bg-success' : c.status == 'REJECTED' ? 'bg-danger' : c.status == 'IN_PROGRESS' ? 'bg-info' : 'bg-warning'}">${c.status}</span>
                    </div>
                </c:forEach>
                <c:if test="${empty myComplaints}"><p class="text-muted small">No complaints filed yet.</p></c:if>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
