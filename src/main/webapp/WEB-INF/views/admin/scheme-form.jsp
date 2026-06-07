<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/admin-header.jsp" %>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-success text-white rounded-top-4 py-3">
                <h5 class="mb-0 fw-bold"><i class="fas fa-hand-holding-heart me-2"></i>
                    ${scheme != null ? 'Edit Scheme' : 'Add New Scheme'}
                </h5>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/schemes" method="post">
                    <c:if test="${scheme != null}"><input type="hidden" name="id" value="${scheme.id}"></c:if>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Scheme Name *</label>
                        <input type="text" name="schemeName" class="form-control" value="${scheme.schemeName}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Description *</label>
                        <textarea name="description" class="form-control" rows="3" required>${scheme.description}</textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Eligibility *</label>
                        <textarea name="eligibility" class="form-control" rows="2" required>${scheme.eligibility}</textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Benefits *</label>
                        <textarea name="benefits" class="form-control" rows="2" required>${scheme.benefits}</textarea>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Last Date *</label>
                            <input type="date" name="lastDate" class="form-control" value="${scheme.lastDate}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Status *</label>
                            <select name="status" class="form-select" required>
                                <option value="ACTIVE" ${scheme.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                                <option value="INACTIVE" ${scheme.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success"><i class="fas fa-save me-2"></i>Save Scheme</button>
                        <a href="${pageContext.request.contextPath}/admin/schemes" class="btn btn-outline-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
