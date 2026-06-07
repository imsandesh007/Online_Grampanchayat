// =============================================
// Gram Panchayat Management System - Scripts
// =============================================

// Auto-dismiss alerts after 4 seconds
document.addEventListener('DOMContentLoaded', function () {
    setTimeout(function () {
        document.querySelectorAll('.alert.alert-dismissible').forEach(function (alert) {
            var bsAlert = bootstrap.Alert.getOrCreateInstance(alert);
            bsAlert.close();
        });
    }, 4000);

    // Highlight active nav link
    const currentPath = window.location.pathname;
    document.querySelectorAll('.navbar-nav .nav-link').forEach(function (link) {
        if (link.getAttribute('href') && currentPath.includes(link.getAttribute('href'))) {
            link.classList.add('active');
            link.style.backgroundColor = 'rgba(255,255,255,0.15)';
            link.style.borderRadius = '6px';
        }
    });

    // Confirm before delete actions
    document.querySelectorAll('a[onclick*="confirm"]').forEach(function(link) {
        // Already handled via onclick attributes in JSP
    });
});

// Form validation helper
function validateNotEmpty(fieldId, message) {
    const val = document.getElementById(fieldId).value.trim();
    if (!val) { alert(message); return false; }
    return true;
}

// Mobile number validation
function validateMobile(mobile) {
    return /^\d{10}$/.test(mobile);
}

// Email validation
function validateEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}
