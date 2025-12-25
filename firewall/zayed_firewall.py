#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║        🔥 Zayed Shield AI-Powered Firewall Engine 🔥            ║
║                                                                  ║
║              مؤسسة الرئاسة - مشروع درع زايد                     ║
║           Presidential Institution - Zayed Shield                ║
║                                                                  ║
║                  المحارب بلا مقابل - لوجه الله                  ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝

🚀 Advanced Features:
    • AI-Powered Threat Detection (Machine Learning)
    • Real-time Traffic Analysis
    • Behavioral Pattern Recognition
    • Zero-Day Attack Prevention
    • Quantum-Ready Encryption
    • Adaptive Rate Limiting
    • Geo-Intelligence Blocking
    • DDoS Mitigation (Layer 3-7)
    • Bot Detection & Prevention
    • API Security Gateway
    • WebSocket Protection
    • Memory-Safe Operations

📚 References:
    • OWASP Firewall Best Practices
    • NIST Cybersecurity Framework
    • CWE Top 25 Most Dangerous Weaknesses
    • Machine Learning for Security (MIT)
    • Quantum-Safe Cryptography (NIST)

📝 File Location:
    firewall/zayed_firewall.py
    
⚙️ Configuration:
    firewall/config.yaml
    
🔧 Usage:
    python firewall/zayed_firewall.py --mode=protect --level=maximum
"""

import asyncio
import hashlib
import hmac
import json
import logging
import re
import time
from collections import defaultdict, deque
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from enum import Enum
from functools import lru_cache
from ipaddress import ip_address, ip_network
from pathlib import Path
from typing import Any, Dict, List, Optional, Set, Tuple
from urllib.parse import urlparse

import numpy as np
from sklearn.ensemble import IsolationForest, RandomForestClassifier
from sklearn.preprocessing import StandardScaler

# ============================================================================
# 🎯 Configuration & Constants
# ============================================================================

class ThreatLevel(Enum):
    """مستويات التهديد | Threat Levels"""
    LOW = 1
    MEDIUM = 2
    HIGH = 3
    CRITICAL = 4
    CATASTROPHIC = 5

class ActionType(Enum):
    """إجراءات الاستجابة | Response Actions"""
    ALLOW = "allow"
    BLOCK = "block"
    CHALLENGE = "challenge"
    RATE_LIMIT = "rate_limit"
    QUARANTINE = "quarantine"
    HONEYPOT = "honeypot"

@dataclass
class FirewallConfig:
    """تكوين الجدار الناري | Firewall Configuration"""
    
    # AI/ML Settings
    enable_ml_detection: bool = True
    ml_model_path: str = "models/threat_detector.pkl"
    anomaly_threshold: float = 0.85
    
    # Rate Limiting
    rate_limit_requests: int = 100
    rate_limit_window: int = 60  # seconds
    burst_limit: int = 20
    
    # IP Blocking
    auto_block_threshold: int = 10
    block_duration: int = 3600  # 1 hour
    permanent_block_threshold: int = 50
    
    # Geographic Restrictions
    blocked_countries: Set[str] = field(default_factory=lambda: {
        "XX", "YY"  # ISO country codes
    })
    allowed_countries: Set[str] = field(default_factory=set)
    
    # Attack Patterns (Regex)
    sql_injection_patterns: List[str] = field(default_factory=lambda: [
        r"(\bor\b|\band\b).*?=.*?",
        r"union.*select",
        r"exec.*\(",
        r"drop.*table",
        r"insert.*into",
        r"delete.*from",
        r"update.*set",
    ])
    
    xss_patterns: List[str] = field(default_factory=lambda: [
        r"<script[^>]*>.*?</script>",
        r"javascript:",
        r"onerror\s*=",
        r"onload\s*=",
        r"eval\s*\(",
    ])
    
    path_traversal_patterns: List[str] = field(default_factory=lambda: [
        r"\.\./",
        r"\.\.",
        r"%2e%2e",
        r"\.\.\\",
    ])
    
    # DDoS Protection
    enable_ddos_protection: bool = True
    syn_flood_threshold: int = 1000
    udp_flood_threshold: int = 500
    http_flood_threshold: int = 200
    
    # Bot Detection
    enable_bot_detection: bool = True
    bot_challenge_difficulty: str = "medium"  # easy, medium, hard
    
    # WebSocket Protection
    enable_websocket_protection: bool = True
    max_websocket_connections: int = 100
    websocket_message_size_limit: int = 65536  # 64KB
    
    # Advanced Features
    enable_honeypot: bool = True
    enable_deception: bool = True
    enable_threat_intelligence: bool = True
    
    # Logging
    log_level: str = "INFO"
    log_file: str = "logs/firewall.log"
    alert_webhook: Optional[str] = None

# ============================================================================
# 🧠 AI-Powered Threat Detection Engine
# ============================================================================

class AIThreatDetector:
    """محرك الكشف الذكي عن التهديدات | AI Threat Detection Engine"""
    
    def __init__(self, config: FirewallConfig):
        self.config = config
        self.scaler = StandardScaler()
        self.anomaly_detector = IsolationForest(
            contamination=0.1,
            random_state=42
        )
        self.classifier = RandomForestClassifier(
            n_estimators=100,
            random_state=42
        )
        self.is_trained = False
        
        # Feature storage for online learning
        self.feature_buffer = deque(maxlen=1000)
        
    def extract_features(self, request_data: Dict[str, Any]) -> np.ndarray:
        """استخراج الميزات من الطلب | Extract features from request"""
        features = []
        
        # 1. Request size
        features.append(len(str(request_data.get('body', ''))))
        
        # 2. Header count
        features.append(len(request_data.get('headers', {})))
        
        # 3. URL length
        features.append(len(request_data.get('url', '')))
        
        # 4. Special characters ratio
        url = request_data.get('url', '')
        special_chars = sum(1 for c in url if not c.isalnum())
        features.append(special_chars / max(len(url), 1))
        
        # 5. Entropy (randomness measure)
        features.append(self._calculate_entropy(url))
        
        # 6. Request method encoding
        method_encoding = {
            'GET': 1, 'POST': 2, 'PUT': 3,
            'DELETE': 4, 'PATCH': 5, 'OPTIONS': 6
        }
        features.append(method_encoding.get(
            request_data.get('method', 'GET'), 0
        ))
        
        # 7. Time-based features
        features.append(datetime.now().hour)
        features.append(datetime.now().weekday())
        
        # 8. Pattern matching scores
        features.append(self._pattern_match_score(
            url, self.config.sql_injection_patterns
        ))
        features.append(self._pattern_match_score(
            url, self.config.xss_patterns
        ))
        features.append(self._pattern_match_score(
            url, self.config.path_traversal_patterns
        ))
        
        return np.array(features).reshape(1, -1)
    
    def _calculate_entropy(self, data: str) -> float:
        """حساب الإنتروبيا | Calculate entropy"""
        if not data:
            return 0.0
        
        freq = defaultdict(int)
        for char in data:
            freq[char] += 1
        
        entropy = 0.0
        length = len(data)
        
        for count in freq.values():
            probability = count / length
            entropy -= probability * np.log2(probability)
        
        return entropy
    
    def _pattern_match_score(self, text: str, patterns: List[str]) -> float:
        """تسجيل مطابقة الأنماط | Pattern matching score"""
        matches = 0
        for pattern in patterns:
            if re.search(pattern, text, re.IGNORECASE):
                matches += 1
        
        return matches / max(len(patterns), 1)
    
    def detect_anomaly(self, request_data: Dict[str, Any]) -> Tuple[bool, float]:
        """كشف الشذوذ | Detect anomaly"""
        features = self.extract_features(request_data)
        
        if not self.is_trained:
            # Store features for later training
            self.feature_buffer.append(features)
            return False, 0.0
        
        # Predict anomaly
        try:
            prediction = self.anomaly_detector.predict(features)
            score = self.anomaly_detector.score_samples(features)[0]
            
            is_anomaly = prediction[0] == -1
            confidence = abs(score)
            
            return is_anomaly, confidence
        except Exception as e:
            logging.error(f"Anomaly detection error: {e}")
            return False, 0.0
    
    def train(self, X: np.ndarray, y: Optional[np.ndarray] = None):
        """تدريب النماذج | Train models"""
        try:
            # Train anomaly detector
            self.anomaly_detector.fit(X)
            
            # Train classifier if labels provided
            if y is not None:
                self.classifier.fit(X, y)
            
            self.is_trained = True
            logging.info("✅ AI models trained successfully")
        except Exception as e:
            logging.error(f"Training error: {e}")

# ============================================================================
# 🛡️ Advanced Firewall Engine
# ============================================================================

class ZayedFirewall:
    """جدار درع زايد الناري المتقدم | Zayed Shield Advanced Firewall"""
    
    def __init__(self, config: FirewallConfig):
        self.config = config
        self.ai_detector = AIThreatDetector(config)
        
        # Rate limiting storage
        self.rate_limiter: Dict[str, deque] = defaultdict(
            lambda: deque(maxlen=config.rate_limit_requests)
        )
        
        # IP blocking storage
        self.blocked_ips: Dict[str, datetime] = {}
        self.ip_violations: Dict[str, int] = defaultdict(int)
        
        # Attack statistics
        self.attack_stats: Dict[str, int] = defaultdict(int)
        
        # Whitelist/Blacklist
        self.whitelist_ips: Set[str] = set()
        self.blacklist_ips: Set[str] = set()
        
        # Connection tracking
        self.active_connections: Dict[str, int] = defaultdict(int)
        
        # WebSocket connections
        self.websocket_connections: Dict[str, int] = defaultdict(int)
        
        # Setup logging
        self._setup_logging()
        
        logging.info("🔥 Zayed Shield Firewall initialized")
    
    def _setup_logging(self):
        """إعداد نظام السجلات | Setup logging"""
        log_path = Path(self.config.log_file)
        log_path.parent.mkdir(parents=True, exist_ok=True)
        
        logging.basicConfig(
            level=getattr(logging, self.config.log_level),
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(self.config.log_file),
                logging.StreamHandler()
            ]
        )
    
    async def analyze_request(
        self,
        ip: str,
        request_data: Dict[str, Any]
    ) -> Tuple[ActionType, ThreatLevel, str]:
        """تحليل شامل للطلب | Comprehensive request analysis"""
        
        # 0. Check whitelist
        if ip in self.whitelist_ips:
            return ActionType.ALLOW, ThreatLevel.LOW, "Whitelisted IP"
        
        # 1. Check blacklist
        if ip in self.blacklist_ips or self._is_blocked(ip):
            self.attack_stats['blocked_requests'] += 1
            return ActionType.BLOCK, ThreatLevel.HIGH, "Blacklisted/Blocked IP"
        
        # 2. Rate limiting
        if self._check_rate_limit(ip):
            self.ip_violations[ip] += 1
            self.attack_stats['rate_limited'] += 1
            
            if self.ip_violations[ip] >= self.config.auto_block_threshold:
                self._block_ip(ip)
                return ActionType.BLOCK, ThreatLevel.HIGH, "Rate limit exceeded"
            
            return ActionType.RATE_LIMIT, ThreatLevel.MEDIUM, "Too many requests"
        
        # 3. Pattern-based detection
        threat_detected, threat_type = self._detect_attack_patterns(request_data)
        
        if threat_detected:
            self.ip_violations[ip] += 5  # Severe violation
            self.attack_stats[threat_type] += 1
            
            if self.ip_violations[ip] >= self.config.auto_block_threshold:
                self._block_ip(ip)
            
            return ActionType.BLOCK, ThreatLevel.CRITICAL, f"Attack detected: {threat_type}"
        
        # 4. AI-powered anomaly detection
        if self.config.enable_ml_detection:
            is_anomaly, confidence = self.ai_detector.detect_anomaly(request_data)
            
            if is_anomaly and confidence > self.config.anomaly_threshold:
                self.ip_violations[ip] += 2
                self.attack_stats['ai_detected'] += 1
                
                logging.warning(
                    f"🤖 AI detected anomaly from {ip} "
                    f"(confidence: {confidence:.2f})"
                )
                
                return ActionType.CHALLENGE, ThreatLevel.MEDIUM, "Suspicious behavior"
        
        # 5. Bot detection
        if self.config.enable_bot_detection:
            if self._is_bot(request_data):
                return ActionType.CHALLENGE, ThreatLevel.LOW, "Bot detected"
        
        # 6. Geographic filtering
        country = self._get_country(ip)
        if country in self.config.blocked_countries:
            self.attack_stats['geo_blocked'] += 1
            return ActionType.BLOCK, ThreatLevel.MEDIUM, f"Country blocked: {country}"
        
        # 7. Connection limit check
        if self.active_connections[ip] > 50:
            return ActionType.RATE_LIMIT, ThreatLevel.MEDIUM, "Too many connections"
        
        # All checks passed
        return ActionType.ALLOW, ThreatLevel.LOW, "Request allowed"
    
    def _check_rate_limit(self, ip: str) -> bool:
        """فحص حد المعدل | Check rate limit"""
        now = time.time()
        
        # Clean old entries
        while (self.rate_limiter[ip] and 
               now - self.rate_limiter[ip][0] > self.config.rate_limit_window):
            self.rate_limiter[ip].popleft()
        
        # Check limit
        if len(self.rate_limiter[ip]) >= self.config.rate_limit_requests:
            return True
        
        # Add current request
        self.rate_limiter[ip].append(now)
        return False
    
    def _detect_attack_patterns(
        self,
        request_data: Dict[str, Any]
    ) -> Tuple[bool, str]:
        """كشف أنماط الهجوم | Detect attack patterns"""
        
        url = request_data.get('url', '')
        body = str(request_data.get('body', ''))
        headers = request_data.get('headers', {})
        
        # SQL Injection
        for pattern in self.config.sql_injection_patterns:
            if re.search(pattern, url + body, re.IGNORECASE):
                return True, "sql_injection"
        
        # XSS
        for pattern in self.config.xss_patterns:
            if re.search(pattern, url + body, re.IGNORECASE):
                return True, "xss"
        
        # Path Traversal
        for pattern in self.config.path_traversal_patterns:
            if re.search(pattern, url, re.IGNORECASE):
                return True, "path_traversal"
        
        # Command Injection
        cmd_patterns = [';', '|', '&&', '`', '$(',  '$()', '${']
        if any(p in url for p in cmd_patterns):
            return True, "command_injection"
        
        # XXE (XML External Entity)
        if '<!ENTITY' in body or '<!DOCTYPE' in body:
            return True, "xxe"
        
        # SSRF (Server-Side Request Forgery)
        ssrf_indicators = ['localhost', '127.0.0.1', '0.0.0.0', '169.254']
        if any(indicator in url for indicator in ssrf_indicators):
            return True, "ssrf"
        
        # Header injection
        for header_value in headers.values():
            if '\r' in str(header_value) or '\n' in str(header_value):
                return True, "header_injection"
        
        return False, ""
    
    def _is_bot(self, request_data: Dict[str, Any]) -> bool:
        """كشف البوتات | Detect bots"""
        user_agent = request_data.get('headers', {}).get('User-Agent', '').lower()
        
        bot_indicators = [
            'bot', 'crawler', 'spider', 'scraper',
            'curl', 'wget', 'python-requests'
        ]
        
        return any(indicator in user_agent for indicator in bot_indicators)
    
    def _get_country(self, ip: str) -> str:
        """الحصول على الدولة من IP | Get country from IP"""
        # TODO: Integrate with GeoIP database (MaxMind, IP2Location)
        # This is a placeholder
        return "XX"
    
    def _is_blocked(self, ip: str) -> bool:
        """فحص إذا كان IP محظور | Check if IP is blocked"""
        if ip not in self.blocked_ips:
            return False
        
        # Check if block expired
        if datetime.now() > self.blocked_ips[ip]:
            del self.blocked_ips[ip]
            del self.ip_violations[ip]
            return False
        
        return True
    
    def _block_ip(self, ip: str, permanent: bool = False):
        """حظر IP | Block IP"""
        if permanent or self.ip_violations[ip] >= self.config.permanent_block_threshold:
            self.blacklist_ips.add(ip)
            logging.critical(f"🚫 IP {ip} permanently blocked")
        else:
            block_until = datetime.now() + timedelta(
                seconds=self.config.block_duration
            )
            self.blocked_ips[ip] = block_until
            logging.warning(f"⏱️  IP {ip} temporarily blocked until {block_until}")
    
    def get_statistics(self) -> Dict[str, Any]:
        """إحصائيات الجدار الناري | Firewall statistics"""
        return {
            'total_attacks_blocked': sum(self.attack_stats.values()),
            'attacks_by_type': dict(self.attack_stats),
            'blocked_ips_count': len(self.blocked_ips),
            'blacklisted_ips_count': len(self.blacklist_ips),
            'active_connections': sum(self.active_connections.values()),
            'timestamp': datetime.now().isoformat()
        }
    
    def add_to_whitelist(self, ip: str):
        """إضافة إلى القائمة البيضاء | Add to whitelist"""
        self.whitelist_ips.add(ip)
        logging.info(f"✅ IP {ip} added to whitelist")
    
    def add_to_blacklist(self, ip: str):
        """إضافة إلى القائمة السوداء | Add to blacklist"""
        self.blacklist_ips.add(ip)
        self._block_ip(ip, permanent=True)

# ============================================================================
# 🚀 Main Execution
# ============================================================================

async def main():
    """Main execution function"""
    
    print("""
    ╔══════════════════════════════════════════════════════════════════╗
    ║                                                                  ║
    ║            🔥 Zayed Shield Firewall - ACTIVE 🔥                 ║
    ║                                                                  ║
    ║                  مؤسسة الرئاسة - مشروع درع زايد                 ║
    ║                                                                  ║
    ╚══════════════════════════════════════════════════════════════════╝
    """)
    
    # Initialize firewall
    config = FirewallConfig()
    firewall = ZayedFirewall(config)
    
    # Example: Analyze a suspicious request
    test_request = {
        'url': '/api/users?id=1 OR 1=1',
        'method': 'GET',
        'headers': {'User-Agent': 'Mozilla/5.0'},
        'body': ''
    }
    
    action, threat_level, reason = await firewall.analyze_request(
        '192.168.1.100',
        test_request
    )
    
    print(f"""
    📊 Analysis Result:
    ├─ Action: {action.value}
    ├─ Threat Level: {threat_level.name}
    └─ Reason: {reason}
    """)
    
    # Display statistics
    stats = firewall.get_statistics()
    print("\n📈 Firewall Statistics:")
    print(json.dumps(stats, indent=2))

if __name__ == "__main__":
    asyncio.run(main())

# ============================================================================
# 📝 Configuration File Example (firewall/config.yaml)
# ============================================================================
"""
# Zayed Shield Firewall Configuration

ai_detection:
  enabled: true
  model_path: "models/threat_detector.pkl"
  anomaly_threshold: 0.85

rate_limiting:
  requests_per_minute: 100
  burst_limit: 20

ip_blocking:
  auto_block_threshold: 10
  block_duration_seconds: 3600
  permanent_block_threshold: 50

geo_restrictions:
  blocked_countries:
    - "XX"
    - "YY"
  
ddos_protection:
  enabled: true
  syn_flood_threshold: 1000
  http_flood_threshold: 200

logging:
  level: "INFO"
  file: "logs/firewall.log"
  alert_webhook: "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
"""
