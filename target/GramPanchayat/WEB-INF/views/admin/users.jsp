<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/admin-header.jsp" %>

<div class="row mb-4">
    <div class="col">
        <h3 class="fw-bold text-success"><i class="fas fa-users me-2"></i>Citizen Management</h3>
    </div>
</div>

<div class="card border-0 shadow-sm rounded-4">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-success">
                    <tr><th>#</th><th>Name</th><th>Email</th><th>Mobile</th><th>Address</th><th>Registered</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                <c:forEach var="u" items="${users}" varStatus="s">
                    <tr>
                        <td>${s.count}</td>
                        <td><i class="fas fa-user-circle text-primary me-2"></i>${u.fullName}</td>
                        <td>${u.email}</td>
                        <td>${u.mobile}</td>
                        <td>${u.address}</td>
                        <td>${u.createdAt}</td>
                        <td><span class="badge ${u.status == 'ACTIVE' ? 'bg-success' : 'bg-danger'}">${u.status}</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${u.status == 'ACTIVE'}">
                                    <a href="${pageContext.request.contextPath}/admin/users?action=deactivate&id=${u.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Deactivate this user?')">
                                        <i class="fas fa-ban"></i> Deactivate
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/users?action=activate&id=${u.id}" class="btn btn-sm btn-outline-success">
                                        <i class="fas fa-check"></i> Activate
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}"><tr><td colspan="8" class="text-center text-muted py-4">No citizens registered yet.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
