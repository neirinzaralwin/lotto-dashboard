export type NotificationStatus = 'draft' | 'sent';

export type NotificationTarget = 'lotto6' | 'lotto7' | 'all';

export interface PushNotificationRecord {
    id: string;
    title: string;
    body: string;
    target: NotificationTarget;
    status: NotificationStatus;
    sentAt?: string | null;
    createdAt: string;
    updatedAt: string;
}

export interface NotificationDraftInput {
    title: string;
    body: string;
    target: NotificationTarget;
}

/** Auto-push when new results are published — FCM topics lotto6 / lotto7. */
export interface NotificationSettings {
    id: string;
    autoNotifyLotto6: boolean;
    autoNotifyLotto7: boolean;
    updatedAt: string;
}
