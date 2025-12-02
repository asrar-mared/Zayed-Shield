#!/usr/bin/env node
'use strict';
// simple_defense_system.js
// نظام حماية بدون مكتبات خارجية - يعمل مباشرة

const { exec, spawn } = require('child_process');
const fs = require('fs');

// الأجهزة المشبوهة
const THREATS = ['192.168.1.50', '192.168.1.57', '192.168.1.72', '192.168.1.79'];

console.log('🛡️ نظام الحماية السريع - تشغيل...');

// 1. حظر فوري للأجهزة المشبوهة
function blockThreats() {
    console.log('🚫 حظر الأجهزة المشبوهة...');
    
    THREATS.forEach(ip => {
        // محاولة حظر باستخدام أوامر مختلفة
        const commands = [
            `iptables -A INPUT -s ${ip} -j DROP 2>/dev/null || echo "tried iptables"`,
            `route add -host ${ip} reject 2>/dev/null || echo "tried route"`,
        ];
        
        commands.forEach(cmd => {
            exec(cmd, (error, stdout, stderr) => {
                if (stdout.includes('tried')) {
                    console.log(`⚠️ محاولة حظر ${ip} (قد يحتاج صلاحيات)`);
                } else {
                    console.log(`✅ تم حظر ${ip}`);
                }
            });
        });
    });
}

// 2. مراقبة الشبكة
function startMonitoring() {
    console.log('👁️ بدء المراقبة...');
    
    setInterval(() => {
        exec('nmap -sn 192.168.1.0/24', (error, stdout) => {
            if (!error) {
                // فحص وجود الأجهزة المشبوهة
                THREATS.forEach(ip => {
                    if (stdout.includes(ip)) {
                        console.log(`🚨 تحذير: ${ip} نشط!`);
                        logThreat(ip);
                        
                        // محاولة إغراق الجهاز المشبوه
                        floodAttacker(ip);
                    }
                });
                
                // عد الأجهزة النشطة
                const activeCount = (stdout.match(/Host is up/g) || []).length;
                console.log(`📊 أجهزة نشطة: ${activeCount}`);
            }
        });
    }, 15000); // كل 15 ثانية
}

// 3. تسجيل التهديدات
function logThreat(ip) {
    const timestamp = new Date().toLocaleString();
    const logEntry = `[${timestamp}] تهديد مرصود: ${ip}\n`;
    
    fs.appendFileSync('threats.log', logEntry);
    
    // حفظ فحص مفصل
    exec(`nmap -p 22,80,443 ${ip}`, (error, stdout) => {
        if (!error) {
            fs.appendFileSync('detailed_scans.log', 
                `\n=== ${timestamp} - ${ip} ===\n${stdout}\n`);
        }
    });
}

// 4. إغراق المهاجم (دفاع مشروع)
function floodAttacker(ip) {
    console.log(`💥 إغراق الجهاز المهاجم ${ip}...`);
    
    // إغراق ping
    exec(`ping -c 100 -i 0.01 ${ip} > /dev/null 2>&1 &`);
    
    // إغراق HTTP requests
    for(let i = 0; i < 50; i++) {
        exec(`curl -s --connect-timeout 1 http://${ip} > /dev/null 2>&1 &`);
    }
}

// 5. فحص الاتصالات المشبوهة
function checkConnections() {
    setInterval(() => {
        exec('ss -tuln', (error, stdout) => {
            if (!error) {
                THREATS.forEach(ip => {
                    if (stdout.includes(ip)) {
                        console.log(`⚠️ اتصال مشبوه مع ${ip}`);
                        logThreat(ip);
                    }
                });
            }
        });
    }, 10000); // كل 10 ثواني
}

// 6. حماية المحافظ (فحص العمليات المشبوهة)
function protectWallets() {
    setInterval(() => {
        exec('ps aux', (error, stdout) => {
            if (!error) {
                // البحث عن عمليات مشبوهة
                const suspiciousProcesses = [
                    'bitcoin', 'ethereum', 'wallet', 'crypto', 'mining'
                ];
                
                suspiciousProcesses.forEach(proc => {
                    if (stdout.toLowerCase().includes(proc)) {
                        console.log(`🔍 عملية محتملة: ${proc}`);
                        fs.appendFileSync('processes.log', 
                            `${new Date().toLocaleString()} - عملية مشبوهة: ${proc}\n`);
                    }
                });
            }
        });
    }, 30000); // كل 30 ثانية
}

// 7. إنشاء تقرير دوري
function generateReport() {
    setInterval(() => {
        const report = {
            time: new Date().toLocaleString(),
            threats: THREATS,
            status: 'MONITORING'
        };
        
        console.log('\n📋 تقرير دوري:');
        console.log(`⏰ الوقت: ${report.time}`);
        console.log(`🎯 أجهزة مراقبة: ${THREATS.length}`);
        console.log(`🔍 حالة النظام: ${report.status}`);
        
        // حفظ التقرير
        fs.writeFileSync(`report_${Date.now()}.json`, JSON.stringify(report, null, 2));
    }, 300000); // كل 5 دقائق
}

// تشغيل جميع الأنظمة
console.log('🚀 تفعيل جميع أنظمة الحماية...');

blockThreats();           // حظر فوري
startMonitoring();        // مراقبة مستمرة  
checkConnections();       // فحص الاتصالات
protectWallets();         // حماية المحافظ
generateReport();         // تقارير دورية

console.log('✅ نظام الحماية نشط ويعمل!');
console.log('📝 السجلات: threats.log, detailed_scans.log, processes.log');
console.log('⏹️  للإيقاف: Ctrl+C');

// معالج الإيقاف
process.on('SIGINT', () => {
    console.log('\n🛑 إيقاف نظام الحماية...');
    console.log('📊 تم حفظ جميع السجلات');
    process.exit(0);
});
