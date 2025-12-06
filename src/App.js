// src/App.js
import React, { useEffect } from 'react';
import SignClient from '@walletconnect/sign-client';

function App() {
  useEffect(() => {
    async function initWalletConnect() {
      try {
        const signClient = await SignClient.init({
          projectId: 'YOUR_PROJECT_ID', // استبدلها بالمعرف الخاص بك من WalletConnect Cloud
          metadata: {
            name: 'Zayed Shield',
            description: 'Sovereign Wallet Integration',
            url: 'https://zayedshield.online',
            icons: ['https://zayedshield.online/icon.png'],
          },
        });

        console.log('✅ WalletConnect v2 initialized');

        signClient.on('session_proposal', (proposal) => {
          console.log('📡 Session Proposal:', proposal);
        });

        signClient.on('session_created', (session) => {
          console.log('🔐 Session Created:', session);
        });

        signClient.on('session_deleted', (session) => {
          console.log('❌ Session Deleted:', session);
        });

        // يمكنك بدء جلسة يدويًا هنا إذا أردت
        // const session = await signClient.connect({ ... });

      } catch (error) {
        console.error('❌ WalletConnect init error:', error);
      }
    }

    initWalletConnect();
  }, []);

  return (
    <div style={{ padding: '2rem', fontFamily: 'sans-serif' }}>
      <h1>🛡️ Zayed Shield</h1>
      <p>مرحبًا بك في واجهة الاتصال السيادية بالمحفظة الرقمية.</p>
    </div>
  );
}

export default App;
