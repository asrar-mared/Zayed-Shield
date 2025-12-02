// security_defense_system.js
// نظام حماية دفاعي متقدم - مثل أمن المباني

const { exec } = require('child_process');
const fs = require('fs');

// قائمة الأجهزة المشبوهة المعروفة
const SUSPICIOUS_IPS = [
    '192.168.1.50',
    '192.168.1.57', 
    '192.168.1.72',
    '192.168.1.79'
];

// إعدادات النظام
const CONFIG = {
    scanInterval: 10000,      // فحص كل 10 ثواني
    logFile: 'security_log.txt',
    alertSound: true,
    autoBlock: true
};

class SecurityDefenseSystem {
    constructor() {
        this.isActive = false;
        this.detectedThreats = new Set();
        console.log('🛡️ نظام الحماية الدفاعي جاهز للتشغيل');
    }

    // بدء النظام
    start() {
        this.isActive = true;
        console.log('🟢 تم تفعيل نظام الحماية');
        
        // إعداد الجدار الناري الأساسي
        this.setupBasicFirewall();
        
        // بدء المراقبة المستمرة
        this.startMonitoring();
        
        // إعداد حماية تلقائية
        this.setupAutoProtection();
    }

    // إعداد جدار الحماية الأساسي
    setupBasicFirewall() {
        console.log('🔧 إعداد جدار الحماية...');
        
        // حظر الأجهزة المشبوهة المعروفة
        SUSPICIOUS_IPS.forEach(ip => {
            this.blockIP(ip);
        });
    }

    // حظر IP معين
    blockIP(ip) {
        const command = `iptables -A INPUT -s ${ip} -j DROP`;
        exec(command, (error, stdout, stderr) => {
            if (!error) {
                console.log(`🚫 تم حظر الجهاز المشبوه: ${ip}`);
                this.logEvent(`BLOCKED: ${ip} at ${new Date().toLocaleString()}`);
            } else {
                console.log(`⚠️ محاولة حظر ${ip} (قد يحتاج صلاحيات root)`);
            }
        });
    }

    // المراقبة المستمرة
    startMonitoring() {
        console.log('👀 بدء المراقبة المستمرة...');
        
        setInterval(() => {
            if (this.isActive) {
                this.scanNetwork();
            }
        }, CONFIG.scanInterval);
    }

    // فحص الشبكة
    scanNetwork() {
        exec('nmap -sn 192.168.1.0/24', (error, stdout, stderr) => {
            if (!error) {
                this.analyzeNetworkScan(stdout);
            }
        });
    }

    // تحليل نتائج فحص الشبكة
    analyzeNetworkScan(scanResult) {
        const activeIPs = this.extractIPs(scanResult);
        
        activeIPs.forEach(ip => {
            if (SUSPICIOUS_IPS.includes(ip) && !this.detectedThreats.has(ip)) {
                this.handleThreatDetection(ip);
            }
        });
    }

    // استخراج IPs من نتائج nmap
    extractIPs(scanResult) {
        const ipRegex = /192\.168\.1\.(\d+)/g;
        const matches = scanResult.match(ipRegex) || [];
        return matches;
    }

    // التعامل مع اكتشاف تهديد
    handleThreatDetection(ip) {
        console.log(`🚨 تحذير أمني: رُصد جهاز مشبوه ${ip}`);
        
        this.detectedThreats.add(ip);
        
        // تسجيل الحدث
        this.logEvent(`THREAT DETECTED: ${ip} at ${new Date().toLocaleString()}`);
        
        // تفعيل إجراءات الحماية
        this.activateProtocols(ip);
        
        // إنذار صوتي
        if (CONFIG.alertSound) {
            console.log('\a\a\a'); // صوت تنبيه
        }
    }

    // تفعيل بروتوكولات الحماية
    activateProtocols(ip) {
        console.log(`🛡️ تفعيل بروتوكولات الحماية ضد ${ip}`);
        
        // 1. تقوية الجدار الناري
        this.strengthenFirewall(ip);
        
        // 2. فحص مفصل للجهاز المشبوه
        this.deepScanSuspiciousDevice(ip);
        
        // 3. حماية الاتصالات
        this.protectConnections();
    }

    // تقوية الجدار الناري
    strengthenFirewall(ip) {
        // حظر جميع البورتات من هذا الجهاز
        const commands = [
            `iptables -A INPUT -s ${ip} -j DROP`,
            `iptables -A OUTPUT -d ${ip} -j DROP`,
            `iptables -A FORWARD -s ${ip} -j DROP`
        ];
        
        commands.forEach(cmd => {
            exec(cmd, () => {
                console.log(`🔒 تم تطبيق حماية إضافية ضد ${ip}`);
            });
        });
    }

    // فحص مفصل للجهاز المشبوه
    deepScanSuspiciousDevice(ip) {
        console.log(`🔍 بدء فحص مفصل للجهاز المشبوه ${ip}`);
        
        exec(`nmap -A -p 1-1000 ${ip}`, (error, stdout, stderr) => {
            if (!error) {
                this.logEvent(`DEEP SCAN RESULT for ${ip}:\n${stdout}`);
                console.log(`📊 تم حفظ نتائج الفحص المفصل لـ ${ip}`);
            }
        });
    }

    // حماية الاتصالات
    protectConnections() {
        console.log('🔐 تفعيل حماية الاتصالات...');
        
        // فحص الاتصالات النشطة
        exec('ss -tuln', (error, stdout) => {
            if (!error) {
                this.logEvent(`ACTIVE CONNECTIONS at ${new Date().toLocaleString()}:\n${stdout}`);
            }
        });
    }

    // إعداد الحماية التلقائية
    setupAutoProtection() {
        console.log('🤖 إعداد نظام الحماية التلقائية...');
        
        // مراقبة محاولات الاتصال المشبوهة
        setInterval(() => {
            this.monitorSuspiciousConnections();
        }, 5000); // كل 5 ثواني
    }

    // مراقبة الاتصالات المشبوهة
    monitorSuspiciousConnections() {
        exec('netstat -an | grep ESTABLISHED', (error, stdout) => {
            if (!error && stdout) {
                // فحص الاتصالات للبحث عن IPs مشبوهة
                SUSPICIOUS_IPS.forEach(ip => {
                    if (stdout.includes(ip)) {
                        console.log(`⚠️ رُصد اتصال نشط مع جهاز مشبوه: ${ip}`);
                        this.logEvent(`SUSPICIOUS CONNECTION: ${ip} at ${new Date().toLocaleString()}`);
                    }
                });
            }
        });
    }

    // تسجيل الأحداث
    logEvent(message) {
        const timestamp = new Date().toLocaleString();
        const logEntry = `[${timestamp}] ${message}\n`;
        
        fs.appendFileSync(CONFIG.logFile, logEntry);
        console.log(`📝 تم تسجيل: ${message}`);
    }

    // إيقاف النظام
    stop() {
        this.isActive = false;
        console.log('🔴 تم إيقاف نظام الحماية');
    }

    // عرض حالة النظام
    getStatus() {
        console.log('\n📊 حالة نظام الحماية:');
        console.log(`🟢 النظام نشط: ${this.isActive ? 'نعم' : 'لا'}`);
        console.log(`🚨 التهديدات المرصودة: ${this.detectedThreats.size}`);
        console.log(`📁 ملف السجل: ${CONFIG.logFile}`);
        
        if (this.detectedThreats.size > 0) {
            console.log('🎯 الأجهزة المشبوهة المرصودة:');
            this.detectedThreats.forEach(ip => {
                console.log(`   - ${ip}`);
            });
        }
    }

    // إنشاء تقرير أمني
    generateSecurityReport() {
        const report = {
            timestamp: new Date().toLocaleString(),
            systemStatus: this.isActive ? 'ACTIVE' : 'INACTIVE',
            threatsDetected: Array.from(this.detectedThreats),
            totalThreats: this.detectedThreats.size,
            suspiciousIPs: SUSPICIOUS_IPS,
            logFile: CONFIG.logFile
        };
        
        const reportFile = `security_report_${Date.now()}.json`;
        fs.writeFileSync(reportFile, JSON.stringify(report, null, 2));
        
        console.log(`📋 تم إنشاء التقرير الأمني: ${reportFile}`);
        return report;
    }
}

// إنشاء وتشغيل النظام
console.log('🚀 تهيئة نظام الحماية الدفاعي...');

const securitySystem = new SecurityDefenseSystem();

// تشغيل النظام
securitySystem.start();

// عرض الحالة كل دقيقة
setInterval(() => {
    securitySystem.getStatus();
}, 60000);

// معالج إيقاف النظام
process.on('SIGINT', () => {
    console.log('\n🛑 جاري إيقاف نظام الحماية...');
    securitySystem.generateSecurityReport();
    securitySystem.stop();
    process.exit(0);
});

// تصدير النظام للاستخدام
module.exports = SecurityDefenseSystem;
