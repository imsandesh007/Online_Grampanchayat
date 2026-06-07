<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/admin-header.jsp" %>

<div class="row mb-4 align-items-center">
    <div class="col">
        <h3 class="fw-bold text-success"><i class="fas fa-hand-holding-heart me-2"></i>Government Schemes</h3>
    </div>
    <div class="col-auto">
        <a href="${pageContext.request.contextPath}/admin/schemes?action=add" class="btn btn-success me-2">
            <i class="fas fa-plus me-2"></i>Add Scheme
        </a>
        <a href="${pageContext.request.contextPath}/admin/schemes?action=registrations" class="btn btn-outline-primary">
            <i class="fas fa-list me-2"></i>View Registrations
        </a>
    </div>
</div>

<div class="card border-0 shadow-sm rounded-4">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-success">
                    <tr><th>#</th><th>Scheme Name</th><th>Eligibility</th><th>Last Date</th><th>Status</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <c:forEach var="s" items="${schemes}" varStatus="st">
                    <tr>
                        <td>${st.count}</td>
                        <td><strong>${s.schemeName}</strong><br><small class="text-muted">${s.description.length() > 60 ? s.description.substring(0,60).concat('...') : s.description}</small></td>
                        <td><small>${s.eligibility}</small></td>
                        <td>${s.lastDate}</td>
                        <td><span class="badge ${s.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'}">${s.status}</span></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/schemes?action=edit&id=${s.id}" class="btn btn-sm btn-outline-warning"><i class="fas fa-edit"></i></a>
                            <a href="${pageContext.request.contextPath}/admin/schemes?action=delete&id=${s.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this scheme?')"><i class="fas fa-trash"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty schemes}"><tr><td colspan="6" class="text-center text-muted py-4">No schemes found.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
