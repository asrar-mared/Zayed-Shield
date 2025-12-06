import SignClient from '@walletconnect/sign-client';

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

    // استمع للأحداث
    signClient.on('session_proposal', (proposal) => {
      console.log('📡 Session Proposal:', proposal);
      // يمكنك هنا قبول الجلسة أو رفضها حسب الحاجة
    });

    signClient.on('session_created', (session) => {
      console.log('🔐 Session Created:', session);
    });

    signClient.on('session_deleted', (session) => {
      console.log('❌ Session Deleted:', session);
    });

    // يمكنك بدء جلسة جديدة أو الانتظار لطلب من المحفظة
    // const session = await signClient.connect({ ... });

  } catch (error) {
    console.error('❌ WalletConnect init error:', error);
  }
}

initWalletConnect();
