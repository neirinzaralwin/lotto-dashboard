SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict BVivy8vDd6UZvOc51lyqNbUWu9RAQod5Pg8b42iMBoe8eJC5U0y7HG6h9R81BPx

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."custom_oauth_providers" ("id", "provider_type", "identifier", "name", "client_id", "client_secret", "acceptable_client_ids", "scopes", "pkce_enabled", "attribute_mapping", "authorization_params", "enabled", "email_optional", "issuer", "discovery_url", "skip_nonce_check", "cached_discovery", "discovery_cached_at", "authorization_url", "token_url", "userinfo_url", "jwks_uri", "created_at", "updated_at", "custom_claims_allowlist") FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") FROM stdin;
00000000-0000-0000-0000-000000000000	c1a19549-a426-4b3e-9120-886923b4bb33	authenticated	authenticated	kawasakura1200@gmail.com	$2a$10$ChC/PW8Kaxxv9mWMRqezL.pQuxYGbw.OaIV9h8bWgEPy1BvbWCwyG	2026-10-01 15:51:31.146517+00	\N		\N		\N			\N	2026-10-19 09:09:12.579668+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true, "algorithms_sort_ascending": true}	\N	2026-09-09 12:37:09.471758+00	2026-10-19 09:09:12.602447+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") FROM stdin;
c1a19549-a426-4b3e-9120-886923b4bb33	c1a19549-a426-4b3e-9120-886923b4bb33	{"sub": "c1a19549-a426-4b3e-9120-886923b4bb33", "email": "kawasakura1200@gmail.com", "email_verified": true, "phone_verified": false}	email	2026-09-09 12:37:09.489556+00	2026-09-09 12:37:09.489597+00	2026-09-09 12:37:09.489597+00	473c3ef9-97f1-40b0-a483-3f5ff1ebcb91
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."instances" ("id", "uuid", "raw_base_config", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_clients" ("id", "client_secret_hash", "registration_type", "redirect_uris", "grant_types", "client_name", "client_uri", "logo_uri", "created_at", "updated_at", "deleted_at", "client_type", "token_endpoint_auth_method") FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") FROM stdin;
e065743b-dc0b-4424-a9da-6fad0e3af7e9	c1a19549-a426-4b3e-9120-886923b4bb33	2026-10-09 00:14:34.938923+00	2026-10-09 00:14:34.938923+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 26_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/23G90 [FBAN/FBIOS;FBAV/581.0.0.24.106;FBBV/1080200871;FBDV/iPhone14,3;FBMD/iPhone;FBSN/iOS;FBSV/26.6.2;FBSS/3;FBCR/;FBID/phone;FBLC/ja_GB;FBOP/80]	60.134.202.162	\N	\N	\N	\N	\N
bfb0d39c-d95f-423f-8922-07a9ae4ea699	c1a19549-a426-4b3e-9120-886923b4bb33	2026-10-19 08:19:50.144948+00	2026-10-19 08:19:50.144948+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36	60.134.202.162	\N	\N	\N	\N	\N
73b26547-80a5-4508-971a-592c436df072	c1a19549-a426-4b3e-9120-886923b4bb33	2026-10-19 09:09:12.580357+00	2026-10-19 09:09:12.580357+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36	124.122.129.23	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
e065743b-dc0b-4424-a9da-6fad0e3af7e9	2026-10-09 00:14:35.032864+00	2026-10-09 00:14:35.032864+00	password	03ee504c-c210-4db0-8db3-d4e1dfbf6f7a
bfb0d39c-d95f-423f-8922-07a9ae4ea699	2026-10-19 08:19:50.178549+00	2026-10-19 08:19:50.178549+00	password	b19f4095-8813-4fef-8085-7dcf743e62c4
73b26547-80a5-4508-971a-592c436df072	2026-10-19 09:09:12.607853+00	2026-10-19 09:09:12.607853+00	password	30a20890-8f60-432d-8d37-2c40a618f493
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_factors" ("id", "user_id", "friendly_name", "factor_type", "status", "created_at", "updated_at", "secret", "phone", "last_challenged_at", "web_authn_credential", "web_authn_aaguid", "last_webauthn_challenge_data") FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_challenges" ("id", "factor_id", "created_at", "verified_at", "ip_address", "otp_code", "web_authn_session_data") FROM stdin;
\.


--
-- Data for Name: mfa_recovery_code_sets; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_recovery_code_sets" ("id", "user_id", "mfa_factor_id", "failed_verification_count", "verification_locked_until", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: mfa_recovery_codes; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_recovery_codes" ("id", "mfa_recovery_code_set_id", "code_hash", "consumed_at", "created_at") FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_authorizations" ("id", "authorization_id", "client_id", "user_id", "redirect_uri", "scope", "state", "resource", "code_challenge", "code_challenge_method", "response_type", "status", "authorization_code", "created_at", "expires_at", "approved_at", "nonce") FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_client_states" ("id", "provider_type", "code_verifier", "created_at") FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_consents" ("id", "user_id", "client_id", "scopes", "granted_at", "revoked_at") FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at", "expires_at") FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
00000000-0000-0000-0000-000000000000	12	hdv2xdr6ugfp	c1a19549-a426-4b3e-9120-886923b4bb33	f	2026-10-09 00:14:34.988846+00	2026-10-09 00:14:34.988846+00	\N	e065743b-dc0b-4424-a9da-6fad0e3af7e9
00000000-0000-0000-0000-000000000000	43	te42tayffsfl	c1a19549-a426-4b3e-9120-886923b4bb33	f	2026-10-19 08:19:50.170782+00	2026-10-19 08:19:50.170782+00	\N	bfb0d39c-d95f-423f-8922-07a9ae4ea699
00000000-0000-0000-0000-000000000000	45	lznteaycjo4k	c1a19549-a426-4b3e-9120-886923b4bb33	f	2026-10-19 09:09:12.591591+00	2026-10-19 09:09:12.591591+00	\N	73b26547-80a5-4508-971a-592c436df072
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at", "disabled") FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format") FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_relay_states" ("id", "sso_provider_id", "request_id", "for_email", "redirect_to", "created_at", "updated_at", "flow_state_id") FROM stdin;
\.


--
-- Data for Name: scim_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."scim_tokens" ("id", "sso_provider_id", "token_hash", "prefix", "created_at", "expires_at", "revoked_at", "last_used_at") FROM stdin;
\.


--
-- Data for Name: scim_users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."scim_users" ("id", "sso_provider_id", "user_id", "resource", "created_at", "updated_at", "deleted_at") FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_domains" ("id", "sso_provider_id", "domain", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."webauthn_challenges" ("id", "user_id", "challenge_type", "session_data", "created_at", "expires_at") FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."webauthn_credentials" ("id", "user_id", "credential_id", "public_key", "attestation_type", "aaguid", "sign_count", "transports", "backup_eligible", "backed_up", "friendly_name", "created_at", "updated_at", "last_used_at") FROM stdin;
\.


--
-- Data for Name: algorithms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."algorithms" ("id", "name", "description", "lottery_type", "is_enabled", "parameters", "created_at", "updated_at") FROM stdin;
5cc25619-6a1a-4b32-b863-dfbacb5077c4	Admin favorites	Manually curated favorite number sets for the mobile app.	lotto6	t	{"kind": "admin_favorites", "slots": 3}	2026-09-21 15:45:30.696491+00	2026-09-21 15:45:30.696491+00
31c2a1b4-4168-4d59-9209-ab99ae7387ef	Admin favorites	Manually curated favorite number sets for the mobile app.	lotto7	t	{"kind": "admin_favorites", "slots": 3}	2026-09-21 15:45:30.696941+00	2026-09-21 15:45:30.696941+00
2f6af3b0-d42f-4ce8-b105-9d306a30ef16	_verify fav	\N	lotto6	t	{}	2026-09-28 08:43:43.012486+00	2026-09-28 08:43:43.012486+00
4dc34384-ba56-483c-9083-e88084ecd4a9	Favorite 1 · 7-draw mode	\N	lotto6	t	{}	2026-09-28 11:40:24.519055+00	2026-09-28 11:40:24.519055+00
dc694945-2daf-4492-9b66-670e35cd7b27	Favorite 2 · 7-draw rarest	\N	lotto6	t	{}	2026-09-28 11:40:24.539723+00	2026-09-28 11:40:24.539723+00
389dbfb2-2b8e-43b5-bd54-212f7bea848d	Favorite 3 · date/time most common	\N	lotto6	t	{}	2026-09-28 11:40:24.557607+00	2026-09-28 11:40:24.557607+00
aaff0653-919b-4912-be10-a341186aab39	Favorite 4 · date/time least common	\N	lotto6	t	{}	2026-09-28 11:40:24.57302+00	2026-09-28 11:40:24.57302+00
adc87b26-04a7-483d-aa5d-62bd2512e67c	Favorite 1 · 7-draw mode	\N	lotto7	t	{}	2026-09-28 11:40:24.588611+00	2026-09-28 11:40:24.588611+00
d0724d65-8fce-4d4f-8567-404e6ae2927a	Favorite 2 · 7-draw rarest	\N	lotto7	t	{}	2026-09-28 11:40:24.605652+00	2026-09-28 11:40:24.605652+00
88e1cb8e-95d6-4f25-a48e-7d24af22ac67	Favorite 3 · date/time most common	\N	lotto7	t	{}	2026-09-28 11:40:24.61998+00	2026-09-28 11:40:24.61998+00
28c550bf-e16a-4134-8771-a878d91b8666	Favorite 4 · date/time least common	\N	lotto7	t	{}	2026-09-28 11:40:24.633731+00	2026-09-28 11:40:24.633731+00
\.


--
-- Data for Name: app_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."app_settings" ("id", "privacy_policy_url", "terms_of_service_url", "updated_at", "favorite_ranges") FROM stdin;
e43f42fd-9b6d-4d85-91c2-aa5576603290	https://privacy-policy-win-search-lotto67.blogspot.com/2026/10/privacy-policy-win-search-loto67-last.html	https://privacy-policy-win-search-lotto67.blogspot.com/2026/10/terms-of-service-win-search-loto67-last.html	2026-10-19 08:56:06.932+00	{"1": {"max": 20, "min": 7}, "2": {"max": 20, "min": 7}, "3": {"max": 20, "min": 15}, "4": {"max": 20, "min": 15}}
\.


--
-- Data for Name: draws; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."draws" ("id", "lottery_type", "draw_number", "draw_date", "winning_numbers", "bonus_numbers", "prize_info", "is_published", "created_at", "updated_at") FROM stdin;
46ea45e8-7b62-48e9-b1f0-eb62eb66fa92	lotto6	1	2000-10-05	{2,8,10,13,27,30}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9bbac14d-f5ea-49df-8e94-e606f983e77f	lotto6	2	2000-10-12	{1,9,16,20,21,43}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3763d866-3ade-491a-bb11-9644087c694f	lotto6	3	2000-10-19	{1,5,15,31,36,38}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fce8df03-122b-4c55-aa90-a3b38c8adad0	lotto6	4	2000-10-26	{16,18,26,27,34,40}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f75b800c-4483-4147-8519-1402f2095af1	lotto6	5	2000-11-02	{9,15,21,23,27,28}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2f842e6f-8151-460e-bcbd-bd65f27564f0	lotto6	6	2000-11-09	{6,12,23,25,28,38}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f65791ee-2695-4ebd-9222-1ced15d256b5	lotto6	7	2000-11-16	{7,19,21,23,33,35}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0e75d259-62f0-4532-9e30-d50704f1b37f	lotto6	8	2000-11-23	{11,16,18,20,42,43}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b4acd832-91e3-4dee-842a-833fd903b8f7	lotto6	9	2000-11-30	{11,19,23,38,39,42}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7369c5a7-e4e0-4618-a919-b18dc0939f19	lotto6	10	2000-12-07	{1,3,19,21,35,39}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2838c2ca-510e-4c85-9f81-303d6372f162	lotto6	11	2000-12-14	{12,26,32,37,40,42}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c49f5c44-378d-4f28-9a1a-259c998255d7	lotto6	12	2000-12-21	{14,17,27,28,35,39}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ccf827d3-be40-4451-a39a-29a6d0feb104	lotto6	13	2000-12-28	{13,29,31,37,41,42}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ea94a7cc-c413-4948-938b-e2887008c072	lotto6	14	2001-01-04	{2,8,11,35,37,38}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
373010b5-314c-4c2f-b424-a65adc43d1e6	lotto6	15	2001-01-11	{4,6,11,20,21,28}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5a7a7264-b92d-4106-bbe5-f942ac70c3c3	lotto6	16	2001-01-18	{5,12,13,29,34,35}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b9f44f45-2ff5-4137-a4d2-67f7cae693d0	lotto6	17	2001-01-25	{14,20,25,34,35,36}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cdb03049-d2e2-4498-9ed0-30a3e78dea15	lotto6	18	2001-02-01	{6,16,18,27,36,41}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c10acb43-0e27-4655-9de9-ae2a1ad730f9	lotto6	19	2001-02-08	{4,8,12,30,33,43}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d6daf222-d18c-4a4b-af18-d0f3b61fa395	lotto6	20	2001-02-15	{7,29,33,35,37,39}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
abc3772f-27e8-4541-9a6d-4d14312eaafe	lotto6	21	2001-02-22	{5,7,13,19,38,41}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ab245336-9da3-4934-b457-b129b295ff70	lotto6	22	2001-03-01	{8,12,16,19,20,35}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
50478e47-21ab-493d-ab9b-b0c50a8ff5c9	lotto6	23	2001-03-08	{7,10,28,32,33,40}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
daba8912-083d-4b56-a339-5969d873eecc	lotto6	24	2001-03-15	{15,18,19,30,36,38}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a58be1bc-9796-425d-af97-6e27f9e05d7a	lotto6	25	2001-03-22	{11,32,34,37,40,43}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e860a408-e863-454d-9dfc-7bc18835d8b6	lotto6	26	2001-03-29	{3,4,11,12,13,43}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b54586e0-3b28-43a7-9102-13d45ae53f34	lotto6	27	2001-04-05	{4,8,20,30,33,38}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b1f5c349-65af-4a84-9386-991cf2424aee	lotto6	28	2001-04-12	{6,11,15,20,31,41}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
47e22f9a-8452-41bb-98ff-5dcbd52efd15	lotto6	29	2001-04-19	{8,12,20,35,37,40}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3c54061a-132b-480e-b540-ca9babb13fc3	lotto6	30	2001-04-26	{4,16,17,19,26,37}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7d30f8c8-2f1c-4c29-b703-44d37d47e486	lotto6	31	2001-05-03	{7,18,22,25,28,43}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5a3a1252-6c18-46fa-a285-b2bcf5412fb3	lotto6	32	2001-05-10	{3,6,7,23,29,41}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e34deec8-3e81-4a09-be65-08af01f64ebb	lotto6	33	2001-05-17	{8,17,22,25,29,41}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e74a8747-67a4-4db3-bdd1-04687a12daf3	lotto6	34	2001-05-24	{2,20,25,30,37,40}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
54cc5cc8-c80c-40b5-b12e-12a1624755f1	lotto6	1001	2015-09-10	{9,12,15,16,18,35}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e578bce6-fc06-4b52-8690-7643e4ceb758	lotto6	1002	2015-09-14	{8,14,22,25,27,41}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5b62dc93-c23a-494b-ab34-dd57ba421444	lotto6	1003	2015-09-17	{13,22,26,34,38,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3fb7f860-3bca-4aca-9fa6-de48b22419e9	lotto6	1004	2015-09-21	{3,21,23,24,27,32}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4ecb43e5-9bff-4e41-a862-fc5c8c5fc267	lotto6	1005	2015-09-24	{5,13,20,24,25,27}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b7e8c378-18f7-4cfc-ab07-ba831ff11a7b	lotto6	1006	2015-09-28	{7,8,16,31,32,33}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
728301be-3642-43ea-8592-2104aa77a5a2	lotto6	2001	2025-05-22	{13,21,24,26,34,36}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c1230d6c-3400-4db5-bcf1-26867bb4093f	lotto6	2002	2025-05-26	{1,17,19,23,36,42}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
45c1f39c-44fc-4e3d-8124-ca415d38e184	lotto6	2003	2025-05-29	{1,5,10,13,35,40}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b9325b2a-ed0d-4972-91ab-7eb5654910cf	lotto6	2004	2025-06-02	{16,18,25,27,31,36}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bbed618f-41c3-4f8c-822f-f82292531c37	lotto6	2005	2025-06-05	{3,7,18,27,33,34}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a8b978a9-4f0b-4b90-823a-6cb12b52bac5	lotto6	2006	2025-06-09	{4,7,19,22,26,28}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
11f09e21-778c-4f94-8392-72fe638d2b79	lotto6	35	2001-05-31	{3,5,13,30,32,41}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e74f9029-b0bf-491d-9233-fad02fb38fd3	lotto6	36	2001-06-07	{1,16,20,23,30,40}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c6753c24-6840-43f2-a165-32efefab2808	lotto6	37	2001-06-14	{3,5,9,17,21,41}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b808f9c2-14f3-4410-b41b-94c89d05173e	lotto6	38	2001-06-21	{2,9,26,27,34,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
512a6c82-e358-45e9-801c-6449704d95e7	lotto6	39	2001-06-28	{10,18,22,25,39,42}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b9af8cc8-7b62-4d0e-aa87-4a03640fd06c	lotto6	40	2001-07-05	{5,17,25,34,38,39}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d678048b-a17b-49c2-988f-0a6887de32cb	lotto6	41	2001-07-12	{18,21,27,33,36,38}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fd36a7d5-7b0f-434f-9be0-328ec79fca01	lotto6	42	2001-07-19	{4,15,21,24,33,37}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fb1ea7b8-9a38-43b3-8c7c-f88460346cc1	lotto6	43	2001-07-26	{1,2,3,15,24,26}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
532b72da-bbb5-4751-a202-8a776111fc72	lotto6	44	2001-08-02	{3,16,24,31,34,42}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6ee21aff-0c17-4abf-8c29-eed786048c8a	lotto6	45	2001-08-09	{7,9,28,32,36,38}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3f2a6502-7e56-432e-91a1-ecd3eebd6a21	lotto6	46	2001-08-16	{11,14,21,24,25,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a0191934-1aa6-41f5-bd09-74228bb09c92	lotto6	47	2001-08-23	{3,11,14,25,27,31}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a0603de8-335b-4b36-9a22-a44d67d0f524	lotto6	48	2001-08-30	{2,5,28,30,33,40}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f259deca-2352-44cd-a689-e4129352319a	lotto6	49	2001-09-06	{2,13,21,31,32,41}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8e1c33e6-565a-41ab-bfbf-7853badff331	lotto6	50	2001-09-13	{5,13,15,25,27,39}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
664c7888-6703-4f32-a322-b4b0882aa7a8	lotto6	51	2001-09-20	{7,15,24,37,38,41}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fe91d8ff-6374-47f3-be5b-6b204f2374de	lotto6	52	2001-09-27	{1,16,24,25,36,42}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
523028df-d91a-4860-a744-80912f9a2af9	lotto6	53	2001-10-04	{2,15,23,37,40,43}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6ba078f6-ee47-4c99-b3c7-7f69ea63d3b4	lotto6	54	2001-10-11	{14,25,26,31,37,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d14aeb0c-681b-4c2f-ab0c-2ab2e7d9378d	lotto6	55	2001-10-18	{11,12,13,14,37,39}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
db67d9b0-c819-4cca-9262-e74816ee8aec	lotto6	56	2001-10-25	{10,13,25,31,32,42}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e998f27a-4bfa-4cce-8f88-2953dabead85	lotto6	57	2001-11-01	{2,14,22,27,35,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
37692736-41fa-49db-b4be-ff1ac4647980	lotto6	58	2001-11-08	{4,8,9,13,16,25}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
91985434-3ac6-4e54-b9c7-2c49b386b657	lotto6	59	2001-11-15	{9,15,17,30,32,41}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
84aa4b65-07b8-4e5e-8561-cd1088fe5bfd	lotto6	60	2001-11-22	{20,21,23,28,30,42}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6e456819-c8cf-4543-9a90-696de711ee9a	lotto6	61	2001-11-29	{4,8,22,25,27,28}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a03570cc-b84e-4e11-994e-051a833e0733	lotto6	62	2001-12-06	{2,3,9,12,15,30}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
76f8bd71-a9ac-41dc-a5f0-91ac992c4bc0	lotto6	63	2001-12-13	{11,16,20,28,34,40}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4265b6fb-d112-4e6d-b0ac-94536914d45a	lotto6	64	2001-12-20	{2,14,19,22,32,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9a9867fb-1e75-4537-9737-53f76bd9fa15	lotto6	65	2001-12-27	{2,10,22,23,31,43}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d1a58c49-8f58-479c-9c06-b425a1fdbfdc	lotto6	66	2002-01-10	{7,15,17,30,33,35}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8e490c6b-f26a-4e35-af57-10e205dfcc14	lotto6	67	2002-01-17	{1,4,6,11,18,25}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
81a536b8-10f2-4d4d-8b9b-6b7ac1ccde3e	lotto6	68	2002-01-24	{16,23,30,35,37,39}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
24dbf96f-98b5-4538-879b-b27b1c6d2536	lotto6	69	2002-01-31	{1,9,31,35,40,41}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c4ee9ce5-f475-46f0-b69a-44e713f6637b	lotto6	70	2002-02-07	{6,11,20,23,24,31}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f1cad41a-810f-4b0b-a789-d3d1e767877c	lotto6	71	2002-02-14	{1,10,11,13,19,20}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
534432a2-f761-4a83-a4e8-11482dba8a63	lotto6	72	2002-02-21	{10,12,24,29,33,37}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f4e2ba18-bf53-4038-80bc-ea713cd6b6db	lotto6	73	2002-02-28	{1,6,15,19,27,36}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e3f9238f-1c34-480e-8813-ca88a96045d3	lotto6	74	2002-03-07	{3,14,27,28,40,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
130bdae6-53da-4d67-b651-e5e2b9aeaa05	lotto6	75	2002-03-14	{2,4,9,19,23,31}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2f76b502-7353-4678-af5a-8a3ce317f63e	lotto6	76	2002-03-21	{1,10,12,16,20,35}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
57bdcb20-3e28-4a88-80cb-88592d5c8ab9	lotto6	77	2002-03-28	{5,10,15,28,37,38}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
55bf05cc-7a3f-46ea-bbb8-74aaea634d9c	lotto6	78	2002-04-04	{5,14,23,32,33,43}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
357fe2ec-168f-433f-ade3-f5fda17fef00	lotto6	79	2002-04-11	{20,22,27,32,36,43}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3421aeda-ee80-4b3e-9da4-ae879afd70dd	lotto6	80	2002-04-18	{1,4,12,16,19,34}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
eb8f0c04-4018-40e1-ae4a-70d06588b06a	lotto6	81	2002-04-25	{1,11,15,23,26,27}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
06448069-e736-4776-8130-0ae6aab6ab12	lotto6	82	2002-05-02	{10,12,19,25,26,39}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4ee3f8c6-2c71-4a2d-b4d0-84f98d34e149	lotto6	83	2002-05-09	{1,16,21,28,35,37}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
233dcf95-fa33-4e27-814a-2055939f79c9	lotto6	84	2002-05-16	{17,19,26,28,35,37}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0c321c4f-47a6-462c-b3f8-2a6682fd7bc4	lotto6	85	2002-05-23	{5,13,18,22,23,32}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
35887b82-2486-4084-aa0f-a142f7e53fd5	lotto6	86	2002-05-30	{3,7,16,24,29,36}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4700e0c1-533e-4cd3-b634-92731968dc57	lotto6	87	2002-06-06	{3,8,12,36,39,41}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d14d9e44-ff19-420a-99e8-e32aab8beab8	lotto6	88	2002-06-13	{5,6,8,20,21,26}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5341f953-2d85-4700-9600-4d43b00b90f4	lotto6	89	2002-06-20	{3,13,23,30,35,43}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
96d91398-1156-4001-9075-993e85295dc8	lotto6	90	2002-06-27	{13,15,17,18,30,32}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e9a8bd57-5877-437e-871e-627fff4ac4d2	lotto6	91	2002-07-04	{13,15,17,26,41,43}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
adabf25b-84f9-42d3-83e8-7d4e164934a3	lotto6	92	2002-07-11	{5,17,20,24,28,40}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d0e84c21-a9ee-4925-bac0-1bcbf8b114fb	lotto6	93	2002-07-18	{10,23,33,36,37,41}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d5e2b6fc-8054-4154-a24d-b07d418db658	lotto6	94	2002-07-25	{11,16,17,18,29,40}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
93f78c98-3315-482e-bb15-f1e3139cb433	lotto6	95	2002-08-01	{2,3,12,15,25,27}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1007a2cc-796a-4209-82ed-39ecd7f7860e	lotto6	96	2002-08-08	{1,13,15,34,36,43}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e263e3cc-64a2-4843-af89-d1c8e670b63e	lotto6	97	2002-08-15	{4,10,17,34,35,42}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
713e3248-3007-4b68-90d0-bf26fa7a6c9d	lotto6	98	2002-08-22	{7,16,34,37,38,39}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cb2cea7a-e590-469e-a665-02da895991e9	lotto6	99	2002-08-29	{5,9,12,28,29,39}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a55cb838-0180-4142-8046-578b7b2d85f4	lotto6	100	2002-09-05	{6,8,11,14,31,33}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e830de2f-1427-40cc-90cc-a4ea1a601856	lotto6	101	2002-09-12	{21,27,29,30,36,40}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0cf314b6-3a77-4c69-abaa-1d919daad10c	lotto6	102	2002-09-19	{4,5,18,27,35,36}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fc734c94-2870-4a98-afc5-1d5e39ce87e1	lotto6	103	2002-09-26	{1,16,17,27,29,34}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
416e0089-757a-48e0-9fde-ba1a55ab2c04	lotto6	104	2002-10-03	{1,11,17,26,28,35}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5de5df42-5cb3-41e7-aff5-cba4cccb79e3	lotto6	105	2002-10-10	{1,9,14,22,25,34}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ad5253db-03ac-4f24-b94e-40b5445ead89	lotto6	106	2002-10-17	{8,11,21,22,25,27}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
843270e2-2a1e-40f5-a053-a8ce3c9b4b9a	lotto6	107	2002-10-24	{4,5,11,12,28,32}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3f876da2-ca38-46d2-8ab6-84b1ca3c830e	lotto6	108	2002-10-31	{9,22,23,25,34,37}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c7e40e9e-6e46-4fc3-80d9-e045e3413b8a	lotto6	109	2002-11-07	{2,5,12,18,30,41}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
57bd51df-01be-43d2-ac16-52d4e2646f31	lotto6	110	2002-11-14	{5,6,8,19,37,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ea3a42ce-edf2-457a-8c23-93156c63f63f	lotto6	111	2002-11-21	{11,15,21,31,32,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9735df7d-7d75-4484-bd57-ca186e7ba2c7	lotto6	112	2002-11-28	{16,18,23,25,29,30}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3a13c139-52b2-48ca-b16e-54a33d82fdae	lotto6	113	2002-12-05	{3,17,27,29,30,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bf997817-462b-46d9-97d4-89e652740df5	lotto6	114	2002-12-12	{7,13,14,29,38,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
509ed3b2-2495-44fc-bb6a-983d4d391434	lotto6	115	2002-12-19	{8,9,11,27,37,39}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7b75caab-86e1-4cf6-ae00-079297fcc3bf	lotto6	116	2002-12-26	{8,10,15,16,26,31}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5360221b-fb8d-438d-b41e-af8b29bc8d13	lotto6	117	2003-01-09	{5,7,19,20,38,43}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
eecd5ed3-8827-4b46-aacd-3e0f6a491ff2	lotto6	118	2003-01-16	{9,13,21,30,32,37}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
96784940-1d0a-432e-9456-758e7395868b	lotto6	119	2003-01-23	{3,4,11,12,15,30}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
edd8a2d1-4d6a-4ad1-a8d6-d0eef5e2599e	lotto6	120	2003-01-30	{15,18,22,25,36,40}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fe18360c-f107-4853-8e85-d5ec5c391f61	lotto6	121	2003-02-06	{3,8,10,22,28,41}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1cd26b20-0132-46c1-9398-162265621c18	lotto6	122	2003-02-13	{19,20,21,25,33,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f67256ab-ae81-4b87-bf2e-5fe5d606756c	lotto6	123	2003-02-20	{14,21,26,28,29,31}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
598b85d1-9f24-4c55-bcab-c8f66a495bdf	lotto6	124	2003-02-27	{4,17,23,30,39,40}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4d90475a-f7a9-472b-8e0a-9489c61a730f	lotto6	125	2003-03-06	{11,15,19,30,36,41}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ed14deaf-3f1d-4587-a744-b7806eea5bc7	lotto6	126	2003-03-13	{5,6,9,10,21,38}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c4fd2132-5ca1-4236-9893-7b325077fb60	lotto6	127	2003-03-20	{14,16,21,26,37,40}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fad71d90-dbca-4a78-ab00-62ea52d5e777	lotto6	128	2003-03-27	{6,10,18,20,29,39}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
813200a6-7e75-43bc-b4ca-ff1d74cdea68	lotto6	129	2003-04-03	{6,18,25,26,30,42}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
96e91c8d-2f6b-454c-a2cf-a112813274fd	lotto6	130	2003-04-10	{22,30,31,34,38,39}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
10e06b5f-3248-4b9b-bdb8-9c0dff6023dc	lotto6	131	2003-04-17	{6,30,33,34,40,43}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
61888186-c1cd-45ad-824c-ced90b380738	lotto6	132	2003-04-24	{3,18,23,31,32,37}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d8dce922-7b67-4c2d-a8fd-5fc2d3af7077	lotto6	133	2003-05-01	{17,24,26,35,40,41}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b0f845fc-c6ea-4419-be0a-721f73f506e6	lotto6	134	2003-05-08	{2,6,11,14,18,19}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
08cc19ac-c6c6-4e76-b87d-d3c8b6171984	lotto6	135	2003-05-15	{7,13,30,33,35,36}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
25d25406-cba1-477f-baec-249a4c2d4818	lotto6	136	2003-05-22	{3,13,26,31,32,39}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
65f674a3-c614-4ba0-b8f1-918247e37aee	lotto6	137	2003-05-29	{10,13,20,22,25,42}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4f69180d-ab91-4b26-b2e4-74f31d4e8fc3	lotto6	138	2003-06-05	{7,9,10,16,23,29}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5ee2c33a-b702-4922-8d2a-101cedcd5c62	lotto6	139	2003-06-12	{10,21,22,28,37,41}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0a0976ed-4452-4179-89c0-af2f5ac1f407	lotto6	140	2003-06-19	{17,19,29,37,39,40}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c5a7527d-8ef3-44e0-9ece-c1cfc61f0cfc	lotto6	141	2003-06-26	{8,9,14,24,32,39}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
58b347c0-2aa4-4418-bfe3-2a6ca377ea8b	lotto6	142	2003-07-03	{2,16,22,27,29,39}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
68ce895d-83d5-440e-896a-98a113dc66cd	lotto6	143	2003-07-10	{17,21,22,27,33,41}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
513e272f-6ea3-46e1-8b67-eb3a50e909b1	lotto6	144	2003-07-17	{1,16,19,33,38,41}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2bc22c5f-a6b8-4a61-b7b7-bee30fa5e3e3	lotto6	145	2003-07-24	{1,4,10,21,23,38}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
50d325fd-6c3d-4a51-80a7-0b081bd33fd4	lotto6	146	2003-07-31	{7,17,27,36,37,39}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3b3a787e-fa85-4e03-bfed-22005e41e053	lotto6	147	2003-08-07	{16,18,20,29,30,38}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
83ab892a-5254-420e-b5d8-0e84c429c986	lotto6	148	2003-08-14	{3,16,18,20,28,29}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
df4a1d29-648a-4a64-917e-31c0c9682e6b	lotto6	149	2003-08-21	{8,9,13,20,33,37}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ac9b237e-dade-4376-b5a7-1ca3fff029c6	lotto6	150	2003-08-28	{10,11,18,20,31,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d703ebcc-d962-45b2-a369-7b59553995b9	lotto6	151	2003-09-04	{3,8,17,25,28,32}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3ab1e36c-5a1f-4f80-826d-4cf869852ef0	lotto6	152	2003-09-11	{4,8,12,16,31,33}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
759bf764-b62b-4c39-8c1a-c07ac15df2e1	lotto6	153	2003-09-18	{4,7,8,12,25,26}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
41736f8c-d410-47ff-a3af-dc8ae1bc82e0	lotto6	154	2003-09-25	{7,9,18,26,27,38}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f13fd6ce-3b0a-4f5d-b234-30de69ce3b21	lotto6	155	2003-10-02	{5,6,7,18,22,27}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7853dcef-8d6b-4867-928d-e08006b2e4c5	lotto6	156	2003-10-09	{6,20,22,29,30,35}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b8f93c84-db19-48bc-88a5-cc9cafab3020	lotto6	157	2003-10-16	{5,8,17,19,25,27}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1420b440-89d3-43b7-ba56-3d0917c3dc6b	lotto6	158	2003-10-23	{1,6,12,35,37,38}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
35fda08a-7f54-437f-821a-c98c7d6e595c	lotto6	159	2003-10-30	{12,23,30,31,38,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1d45aadc-1a56-40de-8904-0ce60b4445c9	lotto6	160	2003-11-06	{4,10,20,30,31,32}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e53f0a03-b65f-4829-ba53-224e83b18a12	lotto6	161	2003-11-13	{23,26,28,33,38,42}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
605c0ebe-3a4f-4ed5-a5e4-c5bbec4eb0e7	lotto6	162	2003-11-20	{3,22,25,30,33,37}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7d5b28d4-4715-469c-95af-d8f5b27dda6c	lotto6	163	2003-11-27	{2,3,11,17,24,34}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ed7a0e67-1161-4156-a064-2f106997c84a	lotto6	164	2003-12-04	{1,2,13,14,35,38}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2179cc1d-4a59-40ab-99b4-c93797daadd2	lotto6	165	2003-12-11	{9,11,16,21,25,36}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d1cf8882-8a16-41c4-ae22-3b2ff0de19d6	lotto6	166	2003-12-18	{14,18,20,28,34,38}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e0c1e6a8-70b6-4cfd-aeb9-4900ee7d13f6	lotto6	167	2003-12-25	{10,14,17,19,29,42}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b73d1a46-8d67-4bc6-b477-ed88e843e2b4	lotto6	168	2004-01-08	{1,6,31,32,36,39}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ccf2c44e-d02e-4fc9-8cc9-2962cc97af5c	lotto6	169	2004-01-15	{3,15,17,19,26,36}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e1f16ac2-b158-44e5-a3f6-3e9c317429db	lotto6	170	2004-01-22	{10,12,15,17,30,31}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4454b6e3-348b-4a03-9f7b-41661145964a	lotto6	171	2004-01-29	{5,6,17,23,32,33}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
977582bf-2882-47d0-a723-b8621ec171cf	lotto6	172	2004-02-05	{10,11,22,23,33,34}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d18480f7-ab3e-4ad9-8593-690bdaa988af	lotto6	173	2004-02-12	{6,10,22,30,31,35}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
77342289-6940-411b-8965-aaeccd28a399	lotto6	174	2004-02-19	{2,9,16,36,38,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ee24a45d-1b0d-418f-92cf-d31cb0c0a20e	lotto6	175	2004-02-26	{2,3,10,22,28,40}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
dcf47ad0-0432-4909-8f80-9151936baddd	lotto6	176	2004-03-04	{8,19,25,31,34,37}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
03d23924-4a94-4388-9dfd-89d435eecce6	lotto6	177	2004-03-11	{6,18,19,30,36,41}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7c031fbb-7347-48d8-b577-cf3eab867777	lotto6	178	2004-03-18	{10,22,27,30,36,39}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0f944b55-ef3a-4f9f-b891-fa1e5e733aa6	lotto6	179	2004-03-25	{3,6,11,13,15,16}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2df3479e-5b5e-436a-9986-76fcc411a0f1	lotto6	180	2004-04-01	{4,10,11,12,20,36}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
32e5f71d-4523-4dad-9201-43dfa9a9c084	lotto6	181	2004-04-08	{1,2,7,21,29,30}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
866b53b4-f958-4ec6-9025-9ef6eb911b22	lotto6	182	2004-04-15	{22,23,28,37,40,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
861b8f7d-3479-438f-84dc-3fd727134079	lotto6	183	2004-04-22	{14,29,31,36,38,40}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
98ab1508-579c-49ca-9562-87adbd5012b7	lotto6	184	2004-04-29	{5,7,23,31,39,42}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9a2ba1d5-b23f-4090-a4e3-ba38b95458ab	lotto6	185	2004-05-06	{8,13,14,18,35,41}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
84ca648a-5d3a-47f5-9962-a267cbf31c8c	lotto6	186	2004-05-13	{7,16,18,33,36,41}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
213f0b60-c1bb-42bc-88ec-e13bcea2c435	lotto6	187	2004-05-20	{12,21,22,27,39,40}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7c3c3900-bf4c-4cf2-8182-223fb73982b9	lotto6	188	2004-05-27	{3,8,18,25,26,39}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a92e4e77-c9c4-436b-963b-ded11563bf3a	lotto6	189	2004-06-03	{3,32,35,36,39,40}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
aa7b6dae-6119-47c3-a9d4-21b04e1db972	lotto6	190	2004-06-10	{17,23,30,31,39,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ddbeec1c-a925-43ad-be48-8166d865fb76	lotto6	191	2004-06-17	{4,7,25,27,34,43}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d80413ed-558f-471d-ae3e-859f18667982	lotto6	192	2004-06-24	{3,7,19,27,39,41}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
84792e17-23d3-400b-8d71-e5a014399ec4	lotto6	193	2004-07-01	{3,4,18,31,40,43}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0764baa7-8e1c-4caf-bfba-ec5e41ff28a4	lotto6	194	2004-07-08	{4,11,12,21,36,38}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5e749398-474a-4f18-9f19-cea3b77ce024	lotto6	195	2004-07-15	{5,10,12,22,26,41}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4a9c005f-bf89-4bab-a08c-07cadf2d98a6	lotto6	196	2004-07-22	{4,5,11,16,30,33}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2423ace7-b54f-4d82-9d2c-989b3431d7cd	lotto6	197	2004-07-29	{9,10,17,22,28,30}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
41714631-0d2c-4288-9c2b-b0fb7aa5e79c	lotto6	198	2004-08-05	{4,5,6,17,20,42}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
acc9d74c-0bfd-41ff-ace8-2b4503f47e0a	lotto6	199	2004-08-12	{3,14,24,25,33,36}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4dfe98ee-e843-4b3d-85b1-666e8b073ec7	lotto6	200	2004-08-19	{4,7,11,19,25,28}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
12a94e1e-a25d-464f-9c87-35e5ac2b6bb3	lotto6	201	2004-08-26	{10,13,16,17,24,39}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bd4cfe51-ece6-4a9a-8f0c-e98fa6cbb3d2	lotto6	202	2004-09-02	{9,18,26,28,33,40}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9ba40af5-26b4-4333-945a-0376ec13dba0	lotto6	203	2004-09-09	{12,18,20,27,35,37}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
aa600637-d930-48f3-9b83-8ab9c768f18b	lotto6	204	2004-09-16	{2,17,20,25,39,42}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b772dd6d-e055-4e6e-b048-d04a1d116954	lotto6	205	2004-09-23	{4,7,9,16,18,34}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cc68095c-8048-470f-9c5b-c1b7cb76541f	lotto6	206	2004-09-30	{1,3,16,22,41,43}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
51ac2078-6843-4f85-9435-1721e5a8d1cf	lotto6	207	2004-10-07	{17,21,23,30,31,34}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0a457189-11ed-4049-b44b-5c2fb01ea45c	lotto6	208	2004-10-14	{18,24,29,32,35,39}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ef756e75-ffe4-49b1-9507-cbdab785c526	lotto6	209	2004-10-21	{8,27,30,35,40,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7330d96e-6f5a-4437-aaa1-e29ccc79bb6f	lotto6	210	2004-10-28	{1,6,21,22,37,40}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2aa2a40a-8340-424d-8b24-e37775c7a240	lotto6	211	2004-11-04	{10,14,23,26,33,36}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e9b8d5a0-6579-4def-8b8a-7461e110af8d	lotto6	212	2004-11-11	{1,11,17,32,35,39}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
31707890-35de-4e2a-9251-0ee3e2ca1100	lotto6	213	2004-11-18	{4,7,18,26,29,43}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
dca2fe7f-8b21-4fef-895a-f91b800ebc13	lotto6	214	2004-11-25	{4,7,9,11,20,36}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8e7b5a95-e8f6-47f4-bf6c-18ade9e7d372	lotto6	215	2004-12-02	{1,4,13,18,22,31}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bd353800-9bad-49c1-ac52-8826d2fd4b3a	lotto6	216	2004-12-09	{9,21,29,33,35,41}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0ddf94b4-1dad-49a6-bcec-28f51f001d1e	lotto6	217	2004-12-16	{8,19,23,27,29,39}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
65c0636d-b5f6-4f54-bcf5-3ee21317e9d7	lotto6	218	2004-12-23	{8,10,18,22,31,36}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4cbeea45-e877-4bc4-8b4f-f75c4fdf1a24	lotto6	219	2004-12-30	{27,28,29,34,35,39}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
41e8f4c8-2a07-4247-a067-6491ad4dab3d	lotto6	220	2005-01-06	{23,25,26,29,33,37}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
af99929b-a829-47c1-a23e-4ffca1527ded	lotto6	221	2005-01-13	{8,27,30,31,38,42}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0389f9ba-9d67-48f6-a53e-ad24b52864ae	lotto6	222	2005-01-20	{4,14,15,22,29,31}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
773c2a13-6909-4dff-b59f-803cfbc6e0ec	lotto6	223	2005-01-27	{7,9,19,26,30,32}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2fb6fa4f-ee0c-49e6-9b36-731cd024012c	lotto6	224	2005-02-03	{12,17,18,19,30,35}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0392832f-1f4e-4622-b4d0-7aad38a6656f	lotto6	225	2005-02-10	{9,11,21,31,35,38}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7e43c014-f0bd-4d0d-b9ca-f8a2642e211b	lotto6	226	2005-02-17	{8,26,36,40,42,43}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
08600797-d0f6-4bfd-8e87-b74793e1b70a	lotto6	227	2005-02-24	{6,13,17,29,32,36}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a2f700e3-e575-48a3-a5b5-62c6bc354b5e	lotto6	228	2005-03-03	{5,8,17,26,36,39}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
407dc79e-c229-402c-bb58-7f8ff88c2dba	lotto6	229	2005-03-10	{8,16,21,24,27,36}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a28f382f-0f79-480b-955d-4cfa7f6c8589	lotto6	230	2005-03-17	{4,9,18,31,36,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
dcb7f15d-489f-4864-8a58-d1c6ed565640	lotto6	231	2005-03-24	{1,4,6,16,18,43}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
223bfce3-7764-49e4-86be-658d4cbf3ea9	lotto6	232	2005-03-31	{1,5,7,26,39,43}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4622e80d-356f-4db8-8c0c-e5bd7e200056	lotto6	233	2005-04-07	{6,18,26,40,41,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
702118ff-937f-4a55-b81a-4bfa49d3a339	lotto6	234	2005-04-14	{11,17,24,26,27,30}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c1a4fedf-ebfa-4f4a-b766-cd4614a4783a	lotto6	235	2005-04-21	{6,21,23,24,28,39}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
21e924b5-f4a0-407e-b2af-a00579ccd9dd	lotto6	236	2005-04-28	{1,8,9,14,34,38}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2e95cb34-1ebb-4cab-92a4-5d9342c05965	lotto6	237	2005-05-05	{1,3,11,13,27,37}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d1c2964b-81b9-4f67-9876-184a6bead0b5	lotto6	238	2005-05-12	{5,10,15,20,33,37}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c6ed9751-1843-4bc1-bd0c-3dc7af172507	lotto6	239	2005-05-19	{4,9,18,30,31,40}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
16195feb-1a56-451c-a3cb-5f3dd39b19df	lotto6	240	2005-05-26	{11,15,26,31,36,39}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
32fa8b8d-fbf8-4691-b164-a5b96aa59dd6	lotto6	241	2005-06-02	{8,14,27,33,36,40}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
777cf3c0-c41e-49a0-93ec-db07797ceb2b	lotto6	242	2005-06-09	{1,10,13,22,29,32}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f52cb841-e5c4-49b2-b806-4423ed4cdd62	lotto6	243	2005-06-16	{5,34,35,38,42,43}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
72a6eedd-80cf-4dee-bad5-be989de9f201	lotto6	244	2005-06-23	{11,12,30,36,38,39}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8eb10065-e945-4f85-a454-f201b1471c13	lotto6	245	2005-06-30	{3,6,18,24,28,36}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
51239ea2-1dd0-4334-8d3e-b010b8fd2552	lotto6	246	2005-07-07	{16,28,32,34,39,42}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d3632426-c76c-4c25-bc4b-ec12bea509ea	lotto6	247	2005-07-14	{8,16,30,32,34,39}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
64aeb3d0-ccca-43ee-8f9c-4be6f9b483db	lotto6	248	2005-07-21	{11,32,35,36,39,41}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
064dc4f1-bf83-4217-a5cd-ccb7ec1a7e12	lotto6	249	2005-07-28	{1,3,17,23,33,35}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6ca87416-f5d2-4ea5-b917-da77fd6cda20	lotto6	250	2005-08-04	{3,8,9,13,22,42}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
18ecf407-9aa9-483a-affb-48ab1423755d	lotto6	251	2005-08-11	{2,12,19,25,29,36}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
711ffbd1-bc82-43ad-9807-22808c813a6b	lotto6	252	2005-08-18	{2,6,13,22,32,33}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
323b20c8-b9f1-4e4f-a431-7caaad366ba9	lotto6	253	2005-08-25	{15,16,19,22,36,43}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a95effa2-5c29-4717-bdae-c7d308a8aec7	lotto6	254	2005-09-01	{12,13,22,23,25,29}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6025a740-5311-414d-bed7-6c63ba7876d9	lotto6	255	2005-09-08	{6,7,12,17,34,42}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
afdb4422-afb0-4b8e-a783-dc7ee03069e7	lotto6	256	2005-09-15	{15,17,18,28,30,37}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b3df70a2-ba1b-42d5-a8e6-6853db33fd5d	lotto6	257	2005-09-22	{7,15,29,30,39,40}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
71719ea3-04fc-4315-b8a2-e189e4e6f260	lotto6	258	2005-09-29	{3,15,16,17,25,31}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0d94198d-7c78-4c9e-a4b1-c3b10f152977	lotto6	259	2005-10-06	{1,12,15,23,34,42}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
30ac2ffb-b836-4595-968b-0d035c3cefc0	lotto6	260	2005-10-13	{11,15,21,31,37,41}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
67d89201-2285-4444-bafd-d85223682b3a	lotto6	261	2005-10-20	{6,17,18,21,35,41}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7036d748-438c-473a-9bb1-b3daf2c7d37e	lotto6	262	2005-10-27	{5,7,11,19,21,25}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
14aad6f6-f315-4e81-aa90-16a06dd4ab43	lotto6	263	2005-11-03	{1,5,13,22,39,41}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8a6d6eb0-e81e-4992-82f3-dba009eb2bb4	lotto6	264	2005-11-10	{2,5,6,8,20,27}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c40eeb16-adb7-4878-876f-b1fa92f916f5	lotto6	265	2005-11-17	{2,3,16,22,23,28}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
21f24eec-4049-41a2-8a61-095178e66fb0	lotto6	266	2005-11-24	{11,15,18,24,30,39}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b4f62c85-19ad-41e6-953e-1866a3047e5b	lotto6	267	2005-12-01	{3,5,8,22,35,38}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4845c6ef-a50a-48e9-a1b9-c191b68996e2	lotto6	268	2005-12-08	{3,6,8,14,24,36}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
33e90420-f2a9-4841-b4f5-15dea063dd4c	lotto6	269	2005-12-15	{1,10,13,15,21,23}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a899d984-9dd8-49a7-8496-8e892c5f4c80	lotto6	270	2005-12-22	{17,19,21,29,33,38}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
47db56cd-6903-48ae-9e5b-f52a9a5928de	lotto6	271	2005-12-29	{9,10,19,25,40,41}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1261115b-ad8a-4eb0-9aa4-3954e378db89	lotto6	272	2006-01-05	{7,12,13,20,23,26}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
13a22e6c-1abb-4a73-b376-88d330fafb4d	lotto6	273	2006-01-12	{4,18,20,21,29,40}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8e8c5a46-efd2-40bd-90eb-155255aabd3b	lotto6	274	2006-01-19	{4,5,14,27,31,39}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e2cda472-b242-4517-9289-c0de742645a3	lotto6	275	2006-01-26	{4,13,15,31,33,40}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
68ea542b-88cf-4b5e-9cf7-1d834d1d349b	lotto6	276	2006-02-02	{6,11,27,30,33,36}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4c9cbbd8-3605-4073-827a-96812c7ab950	lotto6	277	2006-02-09	{7,9,18,20,30,38}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0a737a02-3733-47a9-9343-e1787e8ce1d3	lotto6	278	2006-02-16	{9,13,14,17,22,38}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2d83150d-f88c-4a76-9b4f-716b7e43c61b	lotto6	279	2006-02-23	{7,11,12,23,30,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bc172967-bd0a-4bcb-8a75-0612ac8668b5	lotto6	280	2006-03-02	{6,12,26,37,38,39}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2434fbd8-864b-4ca5-8ee3-7fe61c7c7e0d	lotto6	281	2006-03-09	{3,9,10,11,19,35}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ab2b03f3-0200-4cdf-8616-cd13954265eb	lotto6	282	2006-03-16	{1,9,17,31,41,43}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
23382f89-a0a3-475b-9991-ef8daadb75b2	lotto6	283	2006-03-23	{6,9,16,22,27,37}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
25a58aea-1f19-47b9-a4ed-749a643c4230	lotto6	284	2006-03-30	{20,26,30,33,35,38}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
259c9c78-757c-4dbf-8586-3b07ae8a1fb1	lotto6	285	2006-04-06	{1,3,9,14,16,29}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
deb78eb0-ccd0-4d17-8673-eab92d663679	lotto6	286	2006-04-13	{10,11,14,28,31,41}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cacefb3a-2c57-4e83-9077-140cb8bf62e4	lotto6	287	2006-04-20	{1,5,18,34,35,39}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
021d27e7-9051-44f5-b93e-cd971569652f	lotto6	288	2006-04-27	{3,4,11,25,28,33}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5ccb8b7a-eb69-4c34-b76c-93747a8d13b0	lotto6	289	2006-05-04	{7,9,12,17,34,38}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cae9a64e-f7b6-4924-b3c2-331c0db96b86	lotto6	290	2006-05-11	{11,13,15,17,22,43}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9d298d6e-fae5-49b5-9d85-2dfb3316ec1f	lotto6	291	2006-05-18	{10,15,20,28,41,43}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7944956c-3f09-4976-83c5-88e154b00807	lotto6	292	2006-05-25	{7,14,27,31,34,39}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c03b4066-6674-41ef-929b-9e87ffe6dcef	lotto6	293	2006-06-01	{6,8,15,17,36,43}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c67a91d8-bf1b-4532-9b63-148d1c23938e	lotto6	294	2006-06-08	{2,5,13,14,17,20}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
027f2ce8-02f2-4f9b-8dd2-5c69eae8da05	lotto6	295	2006-06-15	{9,12,18,20,37,43}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fd72f928-a6e0-4b18-bd58-e12cc6003f8b	lotto6	296	2006-06-22	{4,19,27,30,31,37}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e0a66b9c-8573-47f2-9ec7-41c36bd89b31	lotto6	297	2006-06-29	{6,8,9,20,38,40}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
aa7a17ac-ef21-4f42-9be3-8cc62d82fe1a	lotto6	298	2006-07-06	{12,25,29,31,35,40}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
046831cf-5e0d-408c-8009-3fa68740262e	lotto6	299	2006-07-13	{2,4,5,17,35,41}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b78f571b-28d0-426d-a2d9-d70494e0b8fb	lotto6	300	2006-07-20	{4,7,29,33,36,39}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8c9a0831-2103-444f-bba6-bc932487dcee	lotto6	301	2006-07-27	{4,5,6,9,10,11}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
13891390-34b1-4c64-a46d-688a2c4408e0	lotto6	302	2006-08-03	{2,4,13,23,38,40}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
35a53d34-de93-446f-874c-6ab8aba594cb	lotto6	303	2006-08-10	{4,24,31,35,37,39}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f031a1af-525f-42b8-811d-6a34dcbebd3d	lotto6	304	2006-08-17	{3,7,8,15,17,31}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a026d783-d418-4a8a-afdb-a97b00d9c7f9	lotto6	305	2006-08-24	{1,2,5,23,31,34}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ab48f0d0-54ae-4077-9344-d7f7ae827c4c	lotto6	306	2006-08-31	{1,20,25,28,31,42}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
07fff3f1-31c6-4571-8ea8-18d924b2c951	lotto6	307	2006-09-07	{1,7,11,32,33,40}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
908397a1-02b3-4def-b29d-7dd4b7c05fea	lotto6	308	2006-09-14	{3,13,18,20,23,28}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7876d37b-521f-46df-8afd-6949a3a34333	lotto6	309	2006-09-21	{1,4,26,36,41,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
16de6a01-674d-44c5-9f7f-569cbd44ee71	lotto6	310	2006-09-28	{3,4,5,18,28,37}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d06a6e2d-320d-42cc-9ff9-38c849b20800	lotto6	311	2006-10-05	{1,16,22,36,37,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
65c6e5df-cdaf-4adf-aff0-1f2048e28c63	lotto6	312	2006-10-12	{2,17,22,29,38,42}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f3279d9b-fabb-4cc2-ad3b-7eeec98c726a	lotto6	313	2006-10-19	{1,19,21,31,32,40}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7b5abbd5-f926-4de4-b71c-fce810094105	lotto6	314	2006-10-26	{3,8,14,30,38,43}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d53e63bf-1e65-467f-8aa1-c01f5ecd731b	lotto6	315	2006-11-02	{1,2,17,24,40,41}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
12a6d5b5-3f8d-4664-834c-190cb427fe19	lotto6	316	2006-11-09	{3,4,20,30,40,41}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6d4948c9-daf0-4f01-bada-8c41175f17c2	lotto6	317	2006-11-16	{7,8,15,30,35,36}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
85beff6f-038d-4572-84e7-9dbc81686f3d	lotto6	318	2006-11-23	{2,7,13,16,36,37}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
337d0f6c-4e10-4c3c-838b-7f1a2a1a60c0	lotto6	319	2006-11-30	{15,20,23,28,37,40}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3033e4d4-ebfc-45d3-ba40-9173a0c855d3	lotto6	320	2006-12-07	{1,5,25,27,38,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
08d9d8d7-b8d5-4482-a679-45346d218e2b	lotto6	321	2006-12-14	{21,29,31,36,38,41}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8893a346-89f0-4c21-8801-6ef76cfd6593	lotto6	322	2006-12-21	{18,19,22,25,35,42}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2ffea882-1037-4cf4-b8fa-1e5d701e4ce8	lotto6	323	2006-12-28	{9,11,21,23,33,39}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
130aa89b-4e44-4107-a9c1-24a05cb5cdeb	lotto6	324	2007-01-04	{5,13,27,37,39,41}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
377bcda6-961a-4bb0-9247-c34a3058776c	lotto6	325	2007-01-11	{6,7,18,29,33,39}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bcecfaec-cd4a-4490-b9c3-5e25c9571f53	lotto6	326	2007-01-18	{1,7,9,14,23,43}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
609cdf7e-4afa-4518-8ded-3c3742f3a315	lotto6	327	2007-01-25	{6,12,14,28,31,36}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5c28aff7-a36d-4003-a482-f226ffebb2b5	lotto6	328	2007-02-01	{3,7,10,12,19,36}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
03f02d3b-031e-47f0-9278-ceb6a1fe4e33	lotto6	329	2007-02-08	{6,8,15,17,39,40}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
07923082-7228-4330-833d-cf3d8da8e1a0	lotto6	330	2007-02-15	{5,12,16,19,28,39}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0f040650-94a6-471e-8e7f-8401d610f490	lotto6	331	2007-02-22	{2,8,17,24,32,38}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
707ff750-d2c7-434e-a191-d648846f5a2c	lotto6	332	2007-03-01	{7,8,16,24,26,34}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
87c24476-0047-4ac1-80b0-68ead9f60d5e	lotto6	333	2007-03-08	{1,5,7,15,41,42}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0264b14e-cda0-41f9-bdba-036475e55789	lotto6	334	2007-03-15	{11,14,17,18,34,36}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7212f4bd-2545-4600-80c8-0b479db6d7ef	lotto6	335	2007-03-22	{4,5,10,23,36,42}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
511616b7-85c9-43bd-a909-8a95aa420cbf	lotto6	336	2007-03-29	{3,6,13,17,20,29}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3b065456-7f41-4d85-bf6d-05332ec92b8e	lotto6	337	2007-04-05	{5,15,16,20,34,39}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
177f0e56-5444-4575-9023-b7a966574dcc	lotto6	338	2007-04-12	{8,10,25,31,39,40}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f0d8497b-59cf-4285-a964-88253e5c2fc4	lotto6	339	2007-04-19	{3,5,9,26,34,36}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
dad05263-c2be-46d1-beef-2a5ca419f09a	lotto6	340	2007-04-26	{4,10,13,31,35,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9c7f7d00-f449-4af1-9715-1ce3634c2ac2	lotto6	341	2007-05-03	{4,14,23,25,28,35}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1cb2607b-d97d-45a8-8597-94dca3f5624c	lotto6	342	2007-05-10	{8,15,26,27,34,38}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c445e299-58d7-4ce9-af5a-71c49ae03e6d	lotto6	343	2007-05-17	{13,28,29,37,38,41}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cb391af0-9472-4539-be7c-1ea8aa0950e1	lotto6	344	2007-05-24	{8,11,16,20,28,36}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0199c093-f865-4e24-9177-fe747ca17f2f	lotto6	345	2007-05-31	{10,21,22,25,35,37}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
99a897b7-e3b8-4cb9-a482-0047998f3d56	lotto6	346	2007-06-07	{4,9,11,12,32,38}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2e0546db-2e3a-4c06-b5a1-a15d5cb552d5	lotto6	347	2007-06-14	{8,20,23,27,32,33}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bb134431-c5af-4423-8959-395910d72dd4	lotto6	348	2007-06-21	{4,5,6,27,36,38}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9f9ecc0a-8fcc-4997-ac51-330e055b5b9a	lotto6	349	2007-06-28	{8,13,15,19,20,30}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0974c338-738e-48dc-9a81-6a4384e349d3	lotto6	350	2007-07-05	{13,18,25,26,29,40}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d75b7e59-37e8-47f8-9ceb-f6cb9f22b120	lotto6	351	2007-07-12	{3,13,16,24,26,43}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f54f9647-a4c5-49b5-9fcd-a17ccec95dff	lotto6	352	2007-07-19	{6,8,24,25,34,38}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
65231a3b-a359-4a33-b658-3934d1e9be61	lotto6	353	2007-07-26	{1,9,15,16,22,26}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
098bb134-be60-4759-80d4-42aa4b22b4c8	lotto6	354	2007-08-02	{4,6,22,31,34,41}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
35a56993-eb22-4cf8-ae4c-add6958365ce	lotto6	355	2007-08-09	{1,11,24,26,36,37}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
967a3cd1-912e-411e-9917-2d8b3a53c779	lotto6	356	2007-08-16	{1,5,8,12,17,29}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
67e7d907-36e9-4b0d-94e7-ad3d2d698835	lotto6	357	2007-08-23	{2,10,11,12,19,38}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9425902b-ade8-4a5d-894b-146b37f9d8d0	lotto6	358	2007-08-30	{12,31,32,34,39,42}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5a9689f0-b301-4e56-8f41-946e50909e1e	lotto6	359	2007-09-06	{3,5,19,20,23,27}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
16bdb3d4-6843-47bf-9e8c-7a0c07d12421	lotto6	360	2007-09-13	{2,3,6,14,26,42}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6489c81f-1113-4a76-8dab-f956d4603deb	lotto6	361	2007-09-20	{1,21,28,30,37,43}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
19a2c56b-8225-442e-a18a-decae9ddc8e9	lotto6	362	2007-09-27	{7,10,15,20,37,40}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ce607e52-8989-4580-b536-da0031faf66b	lotto6	363	2007-10-04	{3,6,7,22,27,31}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0ab5d930-7d2f-4717-b6b8-ad9c80b52173	lotto6	364	2007-10-11	{7,11,12,19,33,42}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a8c5d4dd-0b87-471a-9496-30e126e61a70	lotto6	365	2007-10-18	{6,19,20,28,36,37}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
77eb46c4-d0af-465b-8f07-fc7caf111fc4	lotto6	366	2007-10-25	{12,13,15,18,30,41}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
779d118b-8705-4a08-a4b1-a0cc94cde5e3	lotto6	367	2007-11-01	{10,13,17,38,41,43}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5318739e-0f34-40d8-9f54-1c0c454f43a4	lotto6	368	2007-11-08	{7,10,18,21,33,35}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d37499b1-5bbf-42a4-b5d2-0606f480f9ef	lotto6	369	2007-11-15	{3,9,12,16,18,37}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d064f752-e1a0-4a08-9683-3ad244c3087b	lotto6	370	2007-11-22	{2,11,13,15,16,32}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3bcb1627-195e-4bb1-82ab-c5cd16b74f45	lotto6	371	2007-11-29	{14,15,23,24,32,34}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d3119c7d-23d3-474b-a422-6e315d1d169c	lotto6	372	2007-12-06	{7,19,28,33,35,39}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4495a520-54ce-4d56-9e4f-03f78a8cef5f	lotto6	373	2007-12-13	{7,14,15,19,35,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1786cf49-7b67-41fc-b857-792255932c5d	lotto6	374	2007-12-20	{4,24,25,26,27,34}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0f9600d9-79d8-477f-bf36-0d8fe1e2c781	lotto6	375	2007-12-27	{7,9,14,17,36,37}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3e039944-71d5-4a8f-959f-02123d2c78f3	lotto6	376	2008-01-10	{20,21,25,27,34,38}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4bf1d140-5dc0-4cbf-9d9c-4945b59f5af4	lotto6	377	2008-01-17	{2,3,8,20,21,24}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fc5ca1e7-76c5-465c-8200-0304377a40b1	lotto6	378	2008-01-24	{11,13,19,26,36,43}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
112000c8-8d31-42bf-88b4-341d98134824	lotto6	379	2008-01-31	{8,13,15,21,33,34}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a14cb476-c312-4c9e-a79b-6ea1d9208d2f	lotto6	380	2008-02-07	{17,22,25,26,27,43}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
60729e18-0b67-4f8f-a68b-36475c098d59	lotto6	381	2008-02-14	{4,13,15,22,39,41}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
63ebe911-102d-4902-8782-3a0c85df652c	lotto6	382	2008-02-21	{2,6,15,28,29,43}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4ea575ba-08b2-49d5-8828-691ce28c09f0	lotto6	383	2008-02-28	{7,12,17,18,24,28}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cfb40801-4e37-47ff-ac26-b8962fa5c298	lotto6	384	2008-03-06	{17,19,20,22,33,41}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
510a7ba2-ee54-4dfe-ad13-911ef5dc12dc	lotto6	385	2008-03-13	{6,31,34,35,37,40}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a6648f7b-860e-4347-9b4a-b5707d98e65c	lotto6	386	2008-03-20	{2,9,11,15,23,25}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ff6929dd-291f-4a62-ade4-1c23733ca920	lotto6	387	2008-03-27	{12,16,19,27,30,32}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fce46287-ebc9-42f7-b01c-931e4e0cf431	lotto6	388	2008-04-03	{5,12,14,18,20,31}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bb7221c4-9990-4aa4-87bd-dbcfd7085f8d	lotto6	389	2008-04-10	{6,12,22,25,31,35}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c14f23ce-951b-4aba-95e8-7015f1567342	lotto6	390	2008-04-17	{5,16,17,22,39,43}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
562a536f-e772-4569-8113-ff2cd282a636	lotto6	391	2008-04-24	{8,20,23,24,29,38}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
052549c6-5c05-4c23-a187-f7850086c980	lotto6	392	2008-05-01	{10,15,18,30,31,37}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1fc228ce-9c86-46a3-8839-824f9318176b	lotto6	393	2008-05-08	{7,18,27,37,38,43}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bb67d961-b8e4-416e-bb30-3c19072ab906	lotto6	394	2008-05-15	{14,27,28,31,37,40}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a270e7f8-e0c8-4b3b-9f9a-6568a54095f2	lotto6	395	2008-05-22	{15,21,26,28,42,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
37cc1861-aec4-4e82-b9ee-707536803ec2	lotto6	396	2008-05-29	{9,12,21,26,33,40}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e52680d9-9f41-4935-9212-5deac767349a	lotto6	397	2008-06-05	{15,16,23,30,39,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7cb1feb4-8965-4460-aed0-5e84e5ad490f	lotto6	398	2008-06-12	{2,31,36,37,39,43}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
09e859db-ee37-4efc-b007-b9e03f194cd8	lotto6	399	2008-06-19	{1,14,17,28,31,37}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3edde572-0fc9-4ac6-b278-a777e3168f28	lotto6	400	2008-06-26	{4,9,19,22,23,33}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
71b04adb-3507-4075-a254-5768e0a31787	lotto6	401	2008-07-03	{14,15,27,34,35,42}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
29fc04f5-b742-4adc-aecb-44c098abcf08	lotto6	402	2008-07-10	{3,18,23,24,29,33}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e3840598-2ed0-4d59-b1b3-bc882e657861	lotto6	403	2008-07-17	{8,10,13,20,24,33}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
dd09db7c-d726-4bc4-86bd-79ef925edc9c	lotto6	404	2008-07-24	{3,10,14,18,26,43}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
25117317-7a01-40e1-a80a-272488e9289d	lotto6	405	2008-07-31	{6,13,19,20,30,31}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1666bdce-422c-43eb-9280-8e027cc71532	lotto6	406	2008-08-07	{1,2,4,16,36,37}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
02d3a731-7b90-416a-b307-500000fb0b14	lotto6	407	2008-08-14	{11,18,19,30,37,39}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bacdd66d-1814-4dfb-9ee4-3e138935b8d2	lotto6	408	2008-08-21	{12,20,23,28,31,32}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
eef2be51-7a7b-4626-8706-f89cefe97858	lotto6	409	2008-08-28	{6,13,17,27,28,36}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
34e69f71-5cf0-400e-a880-2829b4ff8635	lotto6	410	2008-09-04	{2,12,16,20,42,43}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
259fed30-ad9d-4c93-85e4-2050eddb1916	lotto6	411	2008-09-11	{2,4,6,24,35,39}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
be7f0a6d-a904-456b-bed0-367d308718ea	lotto6	412	2008-09-18	{2,6,7,9,16,19}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bb1c2b2e-bc4e-4a50-9477-58383b591c3a	lotto6	413	2008-09-25	{2,14,15,26,35,37}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2f23fb3e-6c6b-46a4-b275-a06b1cbaea87	lotto6	414	2008-10-02	{1,2,4,5,9,25}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5c46a829-8c76-4026-b080-6bcafcb32275	lotto6	415	2008-10-09	{9,28,33,34,37,43}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8bfce3ad-be7c-4246-bf77-6927e640309b	lotto6	416	2008-10-16	{12,15,22,24,29,37}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
49964dfe-a965-4968-a54a-7f2d6b28a79d	lotto6	417	2008-10-23	{3,20,23,30,31,37}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
deb3eea6-bb42-41aa-a0e5-0327ebfe88bc	lotto6	418	2008-10-30	{3,12,16,25,32,36}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
188479a9-985b-4e52-b66c-27ef9d994944	lotto6	419	2008-11-06	{5,8,16,25,26,30}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b3de4363-c8fb-467b-9f52-6b84af3fc539	lotto6	420	2008-11-13	{14,19,21,28,29,31}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5d097ca2-917d-48cd-ba92-732cba708bbb	lotto6	421	2008-11-20	{2,6,8,10,25,34}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c3b10d69-2b90-4acc-989c-fbb214cd5c2b	lotto6	422	2008-11-27	{5,6,7,8,28,38}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a32d5f5e-d3ca-437c-84e4-a4c78740f13b	lotto6	423	2008-12-04	{1,2,3,30,35,36}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
11738ad9-fd98-46a6-bdfc-b05a02211760	lotto6	424	2008-12-11	{3,13,17,25,40,41}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
76a86245-8725-4628-8b9b-2b0e1003a153	lotto6	425	2008-12-18	{2,3,12,20,34,43}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ae26e33d-6ff0-459c-928f-1fbfedb7f560	lotto6	426	2008-12-25	{6,8,9,29,32,37}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
58348ff5-3955-4512-93f3-5a94cf4e5277	lotto6	427	2009-01-08	{5,12,13,33,39,42}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
44cc5d0c-4a76-4e81-91fe-44f6d4073de7	lotto6	428	2009-01-15	{8,16,18,35,42,43}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e769ce03-021a-40d2-8a87-50a6ff55a56f	lotto6	429	2009-01-22	{17,25,29,33,37,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ccaf0810-782d-4aa4-be67-2edb0874b61e	lotto6	430	2009-01-29	{1,8,18,26,34,42}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b80abc33-7eee-42a1-8172-4fc3be0be88b	lotto6	431	2009-02-05	{1,5,19,20,35,41}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
68865cc8-0315-4059-8e04-e8708ba1d062	lotto6	432	2009-02-12	{8,20,23,24,42,43}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d2fd8b8e-7bd7-42c9-be55-669003c839b1	lotto6	433	2009-02-19	{3,9,11,24,26,34}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
af7dd247-3790-443f-ad9c-91ebffe221c1	lotto6	434	2009-02-26	{3,12,19,33,35,36}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2f64197a-e879-4e9c-bc54-50532716a695	lotto6	435	2009-03-05	{2,11,12,28,35,37}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bb529f51-ba33-4070-9b4e-c736a90417de	lotto6	436	2009-03-12	{4,12,21,22,27,38}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d659c336-877b-4081-a251-08e50b48aeae	lotto6	437	2009-03-19	{2,5,11,21,23,43}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
af9bea8f-6830-494b-a42b-9ef63b27a3e3	lotto6	438	2009-03-26	{3,9,16,17,20,31}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a5d9a37c-495c-4e62-b322-3d411c4f5ef7	lotto6	439	2009-04-02	{11,14,20,28,32,41}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8bde58c7-37ca-443b-af62-2b4dd59f1be3	lotto6	440	2009-04-09	{9,23,29,30,31,39}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cc298a72-39b0-40ef-84df-46ec7103a590	lotto6	441	2009-04-16	{10,18,33,34,39,41}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f2438425-4132-482c-8792-4837ef40aab7	lotto6	442	2009-04-23	{2,23,26,35,41,42}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9d9b2d75-c0c8-4837-878b-49942987a32e	lotto6	443	2009-04-30	{6,10,21,22,23,35}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
42f8dc9b-6e7c-4977-afcc-7c4dc12a89aa	lotto6	444	2009-05-07	{5,13,16,18,24,32}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
94863385-c51a-4b8a-8bbb-9ed182e0bd22	lotto6	445	2009-05-14	{10,20,23,26,37,40}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ef0f1a48-8140-4456-abc1-838977255a40	lotto6	446	2009-05-21	{3,8,17,26,27,36}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
26f1de2e-835b-4996-8caa-298fb48bf811	lotto6	447	2009-05-28	{15,23,29,36,42,43}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
94a577e2-3de3-4332-a714-808dad2bf6c3	lotto6	448	2009-06-04	{9,23,32,35,39,42}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1ac0455c-ac34-4b55-a0a2-8bd075f9b58d	lotto6	449	2009-06-11	{19,20,21,23,27,32}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a9f5bbce-dd5a-4a31-82d4-229644ced683	lotto6	450	2009-06-18	{15,20,21,32,40,42}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
076e59fa-49ba-4dd3-a81d-01e65ccf2bcf	lotto6	451	2009-06-25	{6,14,16,19,26,39}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
afc38209-ea82-4e5a-90e6-5fc3cd22c87a	lotto6	452	2009-07-02	{1,5,25,27,29,40}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4b6838b1-b665-4c47-84fc-cb0d8b84f016	lotto6	453	2009-07-09	{7,17,19,27,35,40}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
581210f8-229c-4fb4-bf1a-491c494e9479	lotto6	454	2009-07-16	{2,16,18,27,42,43}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6079b288-fc57-4b01-a3b3-7a0c20f7ab71	lotto6	455	2009-07-23	{11,20,26,28,30,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
aa8baab6-62eb-4015-bbf7-9cdc4c4686be	lotto6	456	2009-07-30	{3,7,15,25,30,39}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ad3d911f-7f08-4915-8ec6-46ba626fb20d	lotto6	457	2009-08-06	{10,12,27,32,34,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
612a62a7-ac87-418c-a162-62b426f66a2e	lotto6	458	2009-08-13	{1,18,27,30,36,40}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c00a319d-c7f5-4d2e-93e7-c1e36ab1c7b3	lotto6	459	2009-08-20	{11,13,27,31,37,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
37fc19a1-ee3a-40d9-b976-df06f5b08e22	lotto6	460	2009-08-27	{18,22,23,32,35,40}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0c717263-576b-4070-9514-ae0cc0d2d7f6	lotto6	461	2009-09-03	{8,10,13,30,32,42}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b38a2f45-ba8d-483b-933b-2c3de559aa8f	lotto6	462	2009-09-10	{2,4,6,16,31,33}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bd3bb0d0-d172-4b1b-862f-b3b6d4030808	lotto6	463	2009-09-17	{10,13,16,25,30,42}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
96c165a6-e523-47a4-a49c-729813118320	lotto6	464	2009-09-24	{10,21,22,25,27,37}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8a1e7337-7a27-4880-a205-251945edf36f	lotto6	465	2009-10-01	{6,24,27,30,32,38}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
89827a3b-eb80-429d-8d26-e090adb9cb11	lotto6	466	2009-10-08	{1,4,19,28,34,40}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
dd2116bb-cdc5-41cb-883b-cd4d1a7addce	lotto6	467	2009-10-15	{18,19,20,24,32,43}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b24cc3b3-6f15-4b99-a3cc-922393fb1025	lotto6	468	2009-10-22	{9,17,26,30,34,40}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d05dc92b-3f3e-4311-b644-b10931db41e9	lotto6	469	2009-10-29	{10,12,20,35,40,43}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
768c62e6-5f9c-4cf0-bcda-61ecba4154a0	lotto6	470	2009-11-05	{1,11,17,23,38,43}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
993434da-adf2-4532-bcae-9d1b47324de9	lotto6	471	2009-11-12	{2,13,14,22,23,32}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4a8f1cd1-d748-4e7c-8c12-5b74599978fb	lotto6	472	2009-11-19	{10,17,28,30,36,42}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9f8439c3-5ffb-4b47-9684-f244861a219e	lotto6	473	2009-11-26	{6,16,17,22,34,37}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
91ce5e51-176d-4bea-9bad-8f2385ae0855	lotto6	474	2009-12-03	{12,15,19,25,28,41}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0be4c228-8576-4762-a28e-753dc50c7037	lotto6	475	2009-12-10	{5,9,10,27,33,42}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e9d75d9f-77e3-4f30-9672-7ecc10c70b01	lotto6	476	2009-12-17	{7,17,22,30,36,40}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c98e8516-370a-42bb-ad18-17e0123165ac	lotto6	477	2009-12-24	{12,14,16,18,38,41}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4861ed7a-732d-4b12-9628-037a7ca8f021	lotto6	478	2010-01-07	{11,14,23,30,31,38}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
52038823-9b58-4f61-9f78-a9ef421d62d9	lotto6	479	2010-01-14	{5,7,14,17,20,27}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c41f7e53-44fd-4eb6-ba86-0523c0f9dbe6	lotto6	480	2010-01-21	{2,5,17,18,35,38}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b17d4bb6-3aa7-4ff9-a1be-cd6d87d54251	lotto6	481	2010-01-28	{2,9,11,24,25,34}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1f265843-bbaa-4d61-a3c5-25926eb010bd	lotto6	482	2010-02-04	{4,30,31,36,37,38}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8e19309e-8f48-478c-a989-c93940adce17	lotto6	483	2010-02-11	{2,8,15,24,33,35}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b4a74132-7b81-42f9-a6fa-6bcaa7e00e34	lotto6	484	2010-02-18	{13,19,25,29,32,35}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
50064690-8c4e-4426-8ca2-bafb96d622a9	lotto6	485	2010-02-25	{14,26,30,33,34,39}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
36f64343-4af5-4da7-80bd-d81ae27d15dc	lotto6	486	2010-03-04	{16,25,27,29,34,41}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0040401e-1c9c-4485-86ea-0e2396c88544	lotto6	487	2010-03-11	{2,6,8,19,22,34}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3151290a-fb08-49b6-a92f-cbd9e0e21ef3	lotto6	488	2010-03-18	{5,15,29,34,39,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
701980f1-4d91-4633-af86-39c73de090a0	lotto6	489	2010-03-25	{6,8,12,30,33,43}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d60d8701-5729-4aef-90c2-f361e5620d47	lotto6	490	2010-04-01	{5,9,13,28,34,40}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fce9c8af-7ec0-4382-b882-1170ea3bc1e1	lotto6	491	2010-04-08	{7,9,20,27,31,34}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
82cf726a-b848-4d93-8f7e-11a3f340f5a9	lotto6	492	2010-04-15	{1,8,12,20,23,37}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d7526c95-500b-421a-b1a1-aab5794cc4b9	lotto6	493	2010-04-22	{8,26,30,36,41,42}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9c1a3922-626f-40a3-bf4e-f6f382b2e2da	lotto6	494	2010-04-29	{8,16,19,23,26,31}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0521de5c-fc8f-4e36-b30f-1366aa912d84	lotto6	495	2010-05-06	{4,6,20,21,29,33}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
16df107f-a034-4e67-9201-0e0282b04afc	lotto6	496	2010-05-13	{2,6,11,29,32,41}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
07a280d7-61c7-4d8f-8e29-f549dbfc31a8	lotto6	497	2010-05-20	{6,12,14,17,36,40}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7f5275a2-0d90-42df-b157-a940c3cc4e7d	lotto6	498	2010-05-27	{1,25,36,41,42,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b81c5348-32b2-4689-865b-52fe0dd69ffa	lotto6	499	2010-06-03	{3,9,15,16,22,35}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cc8f2e1d-bb9f-4aec-99ed-008904c8e4a0	lotto6	500	2010-06-10	{6,20,28,31,34,38}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1c1b2cc6-8bee-4376-8ed6-1ea6a726b54e	lotto6	501	2010-06-17	{3,17,21,23,36,38}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
88cdae5b-3da9-4ed8-bea5-51ce96cdad13	lotto6	502	2010-06-24	{9,12,27,28,29,41}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d7340ab4-3baf-4318-941b-1bc38c4cfdd7	lotto6	503	2010-07-01	{1,18,25,27,28,39}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0c0d6ac6-52ef-41b7-b108-d0f6dad050cd	lotto6	504	2010-07-08	{12,21,22,27,29,31}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ad01483c-4d0a-41f3-bb1f-d51924a72687	lotto6	505	2010-07-15	{19,21,27,33,34,43}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4149b780-1f8d-4ec5-9d98-af53363e948b	lotto6	506	2010-07-22	{5,11,21,27,37,39}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cf7aef51-5838-412a-b8be-b8d66bd108be	lotto6	507	2010-07-29	{5,14,19,21,28,31}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7671c5ac-df13-4190-a442-dd29cb53d396	lotto6	508	2010-08-05	{1,7,14,15,24,42}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
db4921fe-010b-4f6e-ab50-c56b2d9f2f45	lotto6	509	2010-08-12	{3,4,12,18,27,28}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9e74e0b7-d109-402f-ab96-e8ec6c86ccce	lotto6	510	2010-08-19	{12,15,26,35,41,43}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f5d5748e-39b4-4d48-8685-4b9ab4dcee03	lotto6	511	2010-08-26	{4,22,23,27,38,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cb76f33e-dc9f-4964-a6e1-c1102ddf21cc	lotto6	512	2010-09-02	{14,20,23,25,33,39}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
de9f3ac9-c2f3-411b-a728-a1bc1f7bba03	lotto6	513	2010-09-09	{1,6,12,14,15,19}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
613ff3e7-2500-483d-a2f8-1ef4c8c0d55a	lotto6	514	2010-09-16	{6,7,14,15,19,41}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
87b257e4-5685-46c8-9429-0c01c05e91c3	lotto6	515	2010-09-23	{2,3,23,25,33,35}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2a8a8c14-c287-494f-b500-a104e07b5b18	lotto6	516	2010-09-30	{2,14,16,17,29,30}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ca4950ab-3e20-48a5-ac36-c8e69b56c359	lotto6	517	2010-10-07	{6,10,13,14,28,37}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3bbc84ee-0891-434d-bf34-dd3292f757fc	lotto6	518	2010-10-14	{14,31,34,35,40,42}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a2be195a-ac38-4ce4-a224-f154021f9dd9	lotto6	519	2010-10-21	{1,13,25,29,30,33}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f35866a1-fda4-486e-b174-3e008243807f	lotto6	520	2010-10-28	{2,4,12,14,26,43}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5b0585d0-a96e-4ead-b1d4-86e315871619	lotto6	521	2010-11-04	{1,8,15,21,23,30}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2736fe96-d52b-4d43-98ab-dd8428c93f85	lotto6	522	2010-11-11	{3,6,16,23,25,43}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d2420ac3-84ab-44b8-a6ce-117491ffdb62	lotto6	523	2010-11-18	{7,8,26,27,41,43}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a0624d84-eb11-4388-b0ef-c534449afdf0	lotto6	524	2010-11-25	{7,11,14,18,35,40}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
48deb0b9-4f3e-4184-b4e9-50e9b19a6e5d	lotto6	525	2010-12-02	{1,11,17,28,33,38}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
491de731-2942-493c-a359-fdcd58dbbc12	lotto6	526	2010-12-09	{8,14,18,19,26,27}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d872b0a7-7cb0-4fdc-a3a4-96b47e827567	lotto6	527	2010-12-16	{5,7,12,23,39,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ba768701-8509-49c9-ba55-7d9329906456	lotto6	528	2010-12-23	{2,5,12,21,28,32}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0419c743-ac06-478c-ab77-a9ab9c04b999	lotto6	529	2010-12-30	{6,19,21,24,31,41}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cf1a2eba-1e58-44b6-b567-d96afd0c7088	lotto6	530	2011-01-06	{1,10,19,30,33,36}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f0de380d-f5b1-4b09-9fb5-94652ab79d5b	lotto6	531	2011-01-13	{5,12,16,24,26,33}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2b055cb0-6ce5-46c2-a8f9-f5506a8a54ea	lotto6	532	2011-01-20	{23,28,33,35,37,42}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9b1c3d7f-a4c0-4b18-ad0d-a4d87e6af451	lotto6	533	2011-01-27	{6,16,24,31,41,43}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fbc89fed-0df2-4acc-b67b-89e93fb4ae56	lotto6	534	2011-02-03	{1,2,19,22,26,37}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ecd41c98-33b4-44c9-ac3a-e9dfbc23f1cb	lotto6	535	2011-02-10	{6,14,23,24,27,32}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
13ffd348-b9bb-4dfa-94f0-34225f550dd2	lotto6	536	2011-02-17	{4,10,12,14,23,36}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ff16f78e-f402-4f14-afcc-12785f65bf21	lotto6	537	2011-02-24	{10,18,22,24,26,37}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9eadd714-c627-427b-a4d3-a643f1520ebd	lotto6	538	2011-03-03	{2,11,14,23,26,33}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
14537013-2145-4592-b81a-eb2ef9cfef08	lotto6	539	2011-03-10	{3,10,13,17,18,28}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
58896989-b6c8-47fc-8e99-2e9cddd21127	lotto6	540	2011-03-17	{15,23,29,35,36,41}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8c1e3217-6a6d-4f7d-a921-a030817e5147	lotto6	541	2011-03-24	{3,4,5,28,34,43}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ba892f5b-1c62-4a15-ab98-3c3a2b14bc16	lotto6	542	2011-03-31	{10,14,23,35,38,41}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4b5f001f-1b3d-4057-9d7e-68dd3eb691da	lotto6	543	2011-04-04	{15,17,18,19,22,31}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7f12d439-6c8e-4505-8c2e-f3e451c982ac	lotto6	544	2011-04-07	{11,14,16,32,41,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d9f095fd-328f-42ef-87e1-eb23d937c2c3	lotto6	545	2011-04-11	{16,21,24,28,32,36}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bc6d4e86-6a46-414b-8e25-5150012bba3e	lotto6	546	2011-04-14	{1,14,30,34,40,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
54ae1cb9-d65b-489e-aa8c-ec03ade4f755	lotto6	547	2011-04-18	{6,10,11,30,32,39}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a502c616-b42b-4aed-b503-14ef06aa7b53	lotto6	548	2011-04-21	{12,13,16,28,29,35}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
14b02836-621d-4a4f-a2bc-9ff409c58521	lotto6	549	2011-04-25	{5,14,27,29,32,33}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
de77577f-7e89-4213-82b4-7c7ebbfd40cc	lotto6	550	2011-04-28	{12,15,19,32,36,42}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
10c572a3-02f7-423e-91b8-c47e3783d9d7	lotto6	551	2011-05-02	{15,16,19,21,26,42}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a886e32d-a569-4f21-b2b7-bf0881805b0b	lotto6	552	2011-05-05	{13,22,26,30,40,41}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
58f5921a-bcf2-4d5e-971b-c95c1a548d95	lotto6	553	2011-05-09	{3,9,11,15,27,37}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
acf816df-edef-4eb2-9ae6-0c9f68aaff06	lotto6	554	2011-05-12	{16,27,34,35,36,38}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2cca4340-cd35-4596-bd15-46acf3c33d91	lotto6	555	2011-05-16	{2,3,7,9,36,42}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4591c377-fad7-4366-b7ae-965fb0f4f3b6	lotto6	556	2011-05-19	{6,9,13,17,29,30}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7c65ef80-df4f-485b-9127-85543820d51b	lotto6	557	2011-05-23	{6,18,23,32,38,43}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
986e35e0-38ec-41c4-bc92-a65b364383e1	lotto6	558	2011-05-26	{4,32,33,38,41,43}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
725ebf10-e816-4fa6-b298-531adfec9143	lotto6	559	2011-05-30	{2,7,16,25,26,43}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2ca2188c-0a19-4906-bb4d-fbb97a5b4e73	lotto6	560	2011-06-02	{4,17,19,37,39,42}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a5374990-2fec-4986-9c09-7ed0a457f189	lotto6	561	2011-06-06	{4,14,30,35,40,41}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cc66ccef-faab-427d-a3c3-85cdc4d050d4	lotto6	562	2011-06-09	{9,10,11,25,30,37}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9a6ad6cc-d70d-4339-9d83-630ba0822c32	lotto6	563	2011-06-13	{4,5,26,28,34,38}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9ef67acb-881f-4815-b2c0-f3c52574ab8e	lotto6	564	2011-06-16	{3,12,18,24,34,39}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3e1a2697-c89b-4617-a18c-61509c892629	lotto6	565	2011-06-20	{3,6,8,21,28,32}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
478a2d99-dd99-43ca-960c-0935e323d933	lotto6	566	2011-06-23	{10,17,18,29,30,41}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
097669f3-14a5-4b0c-80ba-5a292adb91a3	lotto6	567	2011-06-27	{7,13,17,23,28,34}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
11cf2f9a-0c81-4071-bc5a-83a30f660a48	lotto6	568	2011-06-30	{7,10,15,31,32,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8e048909-eecb-4332-ad02-6c3de4a8688a	lotto6	569	2011-07-04	{4,19,21,25,28,40}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7fa97cde-8f65-4518-9abd-0dc407be347f	lotto6	570	2011-07-07	{2,4,10,28,38,43}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d2193333-49ab-48cd-a16a-d7786ed99af8	lotto6	571	2011-07-11	{6,20,21,23,33,38}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
048756ab-91ec-44ed-93f8-e3d440a37092	lotto6	572	2011-07-14	{10,12,18,38,42,43}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5f819717-7351-40fe-9689-f220e83d1ba6	lotto6	573	2011-07-18	{3,5,21,30,37,38}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e5f51566-f456-406d-ac90-3b553f49ca68	lotto6	574	2011-07-21	{4,11,16,20,26,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2a9b64c3-01c0-4178-ad36-87fbcfbe4055	lotto6	575	2011-07-25	{4,11,17,21,23,30}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f26cd717-e481-4bd9-98cd-9d3e1fc4544c	lotto6	576	2011-07-28	{8,9,21,24,29,37}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7798cd5f-9390-4c4d-9842-ae4a60078308	lotto6	577	2011-08-01	{3,12,29,31,36,37}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2b1d3a22-9003-49c4-aaaf-cf2c0c54905b	lotto6	578	2011-08-04	{16,22,23,27,33,37}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d5fa1285-9c75-4dbf-94bf-38c0e99df076	lotto6	579	2011-08-08	{6,8,17,19,23,42}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5aaf2315-a412-417a-858a-0bfc6797dbd8	lotto6	580	2011-08-11	{12,15,17,25,35,43}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
77cf8eb6-c6de-4dde-a27c-479e5b0ac2cf	lotto6	581	2011-08-15	{5,22,28,29,35,39}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0dc4f022-0fde-4ac9-a7f6-3cad876bac77	lotto6	582	2011-08-18	{7,10,14,25,32,38}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
97f1d17b-abdb-44df-b960-81f9ca5d06d9	lotto6	583	2011-08-22	{2,12,17,18,40,43}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b97b6859-8579-4e0f-ae3e-491cbe0242a7	lotto6	584	2011-08-25	{10,11,24,26,37,38}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6d682ca8-72d1-4585-b72f-bbb90aff836b	lotto6	585	2011-08-29	{1,28,32,34,41,42}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bede4c5a-b048-45d9-986b-0d2ab86ebee7	lotto6	586	2011-09-01	{6,7,10,23,36,42}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7b24422d-b40a-436a-b872-3b4d226bcc36	lotto6	587	2011-09-05	{10,12,18,27,33,40}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
78c018fc-66ec-48f0-bf34-9d4f52725eb5	lotto6	588	2011-09-08	{8,13,18,33,34,36}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
90a6d1a7-b094-4e49-b16c-d254f7535422	lotto6	589	2011-09-12	{1,9,10,28,41,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7af0c6e6-639b-442b-af8b-92eee95f5905	lotto6	590	2011-09-15	{20,24,25,27,32,37}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
56c20bf0-e5d6-434c-8bb0-3c3bea39f632	lotto6	591	2011-09-19	{1,13,16,22,27,33}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8bfe1e74-f087-4e3d-9c2d-48b2d9bb5aa5	lotto6	592	2011-09-22	{12,14,22,23,34,41}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
720a2334-bca2-49df-8e2e-b9e9bc8f67b1	lotto6	593	2011-09-26	{2,10,16,26,29,30}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
704e0890-a55f-41fb-bf41-c4ba0752c248	lotto6	594	2011-09-29	{4,5,15,30,34,38}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
df3deff0-8afa-499d-a581-18485598efa5	lotto6	595	2011-10-03	{1,5,15,22,39,40}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4528c27d-c09c-4548-83fe-be2ac537ab26	lotto6	596	2011-10-06	{2,13,17,24,29,34}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8da92ddb-4803-41f5-b5de-6ecbb2ec8366	lotto6	597	2011-10-10	{3,4,7,13,16,23}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e9ddd689-4d9d-4328-9468-acd6e65fb5a3	lotto6	598	2011-10-13	{6,10,15,21,36,41}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d54eab59-2db7-4d06-8820-096c6013e22d	lotto6	599	2011-10-17	{1,2,8,13,27,39}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
95e28283-2956-4430-9b7e-4f1c8e26e0c4	lotto6	600	2011-10-20	{3,20,23,24,28,35}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
170dd56c-5f20-4372-82be-c384b1e4985e	lotto6	601	2011-10-24	{6,22,25,26,30,39}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ae4ae6d7-2cb5-4718-8aa2-e3e90b7275c8	lotto6	602	2011-10-27	{8,13,15,18,24,41}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f24030bc-030b-48d3-9260-8c7919d1efb8	lotto6	603	2011-10-31	{3,8,18,21,23,42}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e131c2e2-3572-4f75-b9b8-a12bbe1b07f7	lotto6	604	2011-11-03	{9,15,20,22,28,43}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9d3cce5b-9573-4045-953d-83a9c6a516b7	lotto6	605	2011-11-07	{1,4,13,25,38,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a064c4d7-122c-4127-9cfb-f8d9ede29d31	lotto6	606	2011-11-10	{8,15,24,26,35,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
092c3dc2-e05e-45b9-a018-1a1fec542754	lotto6	607	2011-11-14	{2,3,8,12,20,21}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1fa37761-113e-4709-9e75-f9e7b92883d6	lotto6	608	2011-11-17	{4,6,16,17,18,26}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
938dc444-275f-4919-ad7e-2f48ff880da9	lotto6	609	2011-11-21	{18,24,36,37,39,41}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e5b3337c-4935-4f0c-aab9-5c373ea6ab93	lotto6	610	2011-11-24	{2,5,12,23,26,41}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2614147b-9790-44c0-b02a-a48182b65af1	lotto6	611	2011-11-28	{10,12,14,24,34,39}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7fa2cd29-518c-4802-ac12-c596a1d51d00	lotto6	612	2011-12-01	{7,18,31,32,39,40}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
39e2352d-f2c9-42da-828f-c4eadeb43afe	lotto6	613	2011-12-05	{2,6,18,26,32,37}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5fa48a76-004e-47cd-a596-9ed03c44d3dc	lotto6	614	2011-12-08	{2,6,22,25,31,42}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
740ec5c6-093e-49b6-bdb8-42e793405fe2	lotto6	615	2011-12-12	{6,16,24,32,36,43}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ddbe9f15-6abc-4e4c-93ff-17a095c7b708	lotto6	616	2011-12-15	{4,7,18,19,24,35}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4c212cae-0e46-42ff-baa5-cbce7460d25e	lotto6	617	2011-12-19	{5,8,18,28,34,35}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5edda14c-3513-4ca8-b2fd-4a2a19f1e76f	lotto6	618	2011-12-22	{4,15,21,31,35,42}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8eb01e42-c2dd-4732-9f78-8404b11627d3	lotto6	619	2011-12-26	{2,11,29,31,33,38}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8dbdeb85-011d-40b5-afb8-25e341bda98a	lotto6	620	2011-12-29	{7,10,13,19,31,38}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e4727cf3-40c9-41b5-80b1-a5d1688d7220	lotto6	621	2012-01-05	{6,15,16,28,36,40}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a1d497a0-fe99-45ca-ac13-3290389e78dc	lotto6	622	2012-01-09	{7,16,18,20,27,36}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
19695b56-a999-42de-aeb9-dbac86793b37	lotto6	623	2012-01-12	{7,8,16,35,39,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ace3016a-e779-4ad3-abcb-7d82524e2197	lotto6	624	2012-01-16	{4,8,12,22,25,30}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9a80ac13-b111-48d8-9877-65738d0c93fa	lotto6	625	2012-01-19	{5,17,26,37,39,42}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6c1af518-86f1-4236-bddd-1755767d38c1	lotto6	626	2012-01-23	{6,13,14,22,26,28}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5cf7841f-fa4c-437a-82a7-5d7db2e7f313	lotto6	627	2012-01-26	{2,4,7,19,34,42}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
56cf26f7-bf16-4cb4-9f67-07e17ebe853d	lotto6	628	2012-01-30	{7,13,15,18,29,38}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0e4418f8-7ad6-4aa4-b311-8170c374ae20	lotto6	629	2012-02-02	{6,16,21,30,34,43}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
212d4fb5-5686-412c-96e1-213a972bbe99	lotto6	630	2012-02-06	{3,7,13,18,19,41}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
84045de3-ba05-46be-8438-a3dae11b88c6	lotto6	631	2012-02-09	{2,5,7,10,36,40}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ba2e8db1-4c33-45f3-b62f-78e3266fd868	lotto6	632	2012-02-13	{3,4,14,21,22,25}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4324ef6e-651f-450d-9d16-7cfe8c17b7f6	lotto6	633	2012-02-16	{7,9,11,14,15,18}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bf97bb46-df4e-41d3-ae21-7e9c7beab592	lotto6	634	2012-02-20	{8,10,13,15,20,40}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f14a46ce-0342-4f18-9a6e-e0dc4ef16bc5	lotto6	635	2012-02-23	{8,11,12,15,41,43}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
65504691-45a9-42bf-b808-10221f90c9ca	lotto6	636	2012-02-27	{2,12,21,23,24,26}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
98594139-3211-49ce-9648-668f7d583f43	lotto6	637	2012-03-01	{7,12,16,28,31,34}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c5055af0-c2e6-459c-91f0-182e0b803bd6	lotto6	638	2012-03-05	{6,11,19,28,35,40}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6bc2d76b-ba11-4ef3-a2d3-3538d7015742	lotto6	639	2012-03-08	{1,16,20,24,33,34}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c5e559f9-1855-4de4-869f-2d2126c64913	lotto6	640	2012-03-12	{3,11,18,20,33,39}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
373318d7-7942-4a58-9181-7b296d35622c	lotto6	641	2012-03-15	{3,14,21,24,26,29}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
003e9922-b9a2-4f2f-acfa-a6e5942b5730	lotto6	642	2012-03-19	{8,13,14,21,33,41}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
13dd742a-fdc7-415d-ac16-c400b932463c	lotto6	643	2012-03-22	{2,6,21,31,35,37}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
470964c5-b009-49f2-b2ab-44bf427c2efa	lotto6	644	2012-03-26	{4,14,22,23,26,42}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
50a3b514-5d12-48ec-9025-b1ebf916f06c	lotto6	645	2012-03-29	{3,10,12,32,33,43}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
20a1a6eb-d271-4bbe-8cc6-2724be61fe65	lotto6	646	2012-04-02	{9,12,14,24,28,33}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d23e59ea-1fdb-43b1-987a-6a58d6341535	lotto6	647	2012-04-05	{2,7,15,22,36,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9df333dc-0d44-4a56-8258-3f123d8db153	lotto6	648	2012-04-09	{22,26,27,28,36,43}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9c11e1e6-eb00-4d01-bf7b-948461b5a045	lotto6	649	2012-04-12	{14,22,29,33,36,40}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
15f177a8-14f5-412f-bc1a-6ecc32541f3e	lotto6	650	2012-04-16	{12,31,34,40,41,43}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
578ed3be-1759-495b-8d7e-bd02dadbad76	lotto6	651	2012-04-19	{4,15,17,34,38,40}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
80504e86-2ffa-4783-9e3c-abd18b950b46	lotto6	652	2012-04-23	{1,10,16,19,20,39}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6ccbf792-469c-47f6-914f-18241dfdba64	lotto6	653	2012-04-26	{13,21,22,26,29,36}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
eb4abdf7-1806-456a-8fa2-570a02749c04	lotto6	654	2012-04-30	{12,18,21,29,32,38}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f85a466f-b1ab-4c57-9c79-356591ccea84	lotto6	655	2012-05-03	{5,10,23,26,28,29}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
133386d3-4dc1-497a-a043-7d315d1e7fb9	lotto6	656	2012-05-07	{2,8,13,17,25,37}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
30c9587f-08a9-4e0a-a90f-d5e78108e224	lotto6	657	2012-05-10	{3,20,29,33,34,40}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
392de03c-5062-4971-a4fc-15bbf094db3b	lotto6	658	2012-05-14	{14,24,32,40,41,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
67e291ef-ef35-4ec2-8d26-9fadc38eb436	lotto6	659	2012-05-17	{21,30,35,39,41,42}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e2de2b12-b606-46c0-a18d-a7c792615dc6	lotto6	660	2012-05-21	{8,20,31,36,37,38}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
58b15303-a346-4a0d-95d5-6caab1e3749f	lotto6	661	2012-05-24	{6,9,17,20,33,40}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
843e4caa-d0eb-43fb-bb2c-c92766236caa	lotto6	662	2012-05-28	{12,31,32,34,36,40}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f31968e2-e522-4ce7-a255-34016f91104d	lotto6	663	2012-05-31	{13,18,21,30,33,40}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cdcc74bb-4901-4a90-a4da-17d8226e8b8a	lotto6	664	2012-06-04	{2,8,11,12,26,29}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c5e43136-98de-463f-aeee-b2d1ca98b6cb	lotto6	665	2012-06-07	{13,22,27,29,36,37}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cd11f396-86a6-42f9-b263-376a3f690b69	lotto6	666	2012-06-11	{2,6,28,30,31,41}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a681a6b1-c4ff-46e9-b607-5c3e0a6b454c	lotto6	667	2012-06-14	{21,31,34,37,39,40}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ffa61e48-2803-4dec-bcb9-388a620f4991	lotto6	668	2012-06-18	{7,13,20,27,34,35}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7dd317d3-4166-440b-8798-9b950e09d80d	lotto6	669	2012-06-21	{4,6,10,17,24,33}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9edb0690-c6a2-468e-8506-3f654c326321	lotto6	670	2012-06-25	{1,4,7,25,32,41}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f5c281b8-6fa4-4b41-8eab-5fc329a51ad2	lotto6	671	2012-06-28	{5,10,14,16,23,38}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a882e5cd-ef1a-46dc-aad1-32d121e1b2d7	lotto6	672	2012-07-02	{1,5,23,24,36,43}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
498e3132-40fb-42d8-b640-675d45514936	lotto6	673	2012-07-05	{2,6,16,27,28,29}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3acd7cba-8635-42fa-97c6-be505b35f63e	lotto6	674	2012-07-09	{8,11,15,22,40,41}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f06665d2-d45d-4dac-8e2f-765bc1394fbe	lotto6	675	2012-07-12	{8,10,15,21,24,34}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e9d79f06-1526-4901-b39f-01b9f998e2d9	lotto6	676	2012-07-16	{2,8,20,33,38,42}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
15fc7eba-3eb2-4c8b-ab10-cb1344602b32	lotto6	677	2012-07-19	{4,11,22,31,32,35}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3f302231-a506-48b0-b12c-b7285a96a8d6	lotto6	678	2012-07-23	{8,24,25,29,32,40}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
32f77ecf-7114-461b-a821-a7b6429e6171	lotto6	679	2012-07-26	{4,5,7,37,41,42}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1144f1bc-6f61-4c24-9ef1-91c927470771	lotto6	680	2012-07-30	{8,9,23,34,38,41}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
80f73f32-7e59-4c3c-b23c-7c83873defe6	lotto6	681	2012-08-02	{1,11,13,30,37,41}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c314382a-521c-4ef2-8d92-7c8d5e1e9f4f	lotto6	682	2012-08-06	{3,5,7,18,19,41}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
29d003cf-bfd5-4e76-9473-ca134cc7dc00	lotto6	683	2012-08-09	{16,24,29,32,35,38}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
62dc1c88-40b2-46f9-9ffc-fd74dcf0a14a	lotto6	684	2012-08-13	{6,7,13,18,27,33}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
19f40f3e-8fea-481f-b8b0-03c02f5d84a3	lotto6	685	2012-08-16	{12,23,27,32,39,43}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c0d1c846-fc90-42cd-bfd1-effa4e89939b	lotto6	686	2012-08-20	{21,24,26,35,37,38}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
36a2e0fa-368e-4f0a-abca-37084a546e65	lotto6	687	2012-08-23	{16,20,27,33,40,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
52f5db48-82e2-401b-9ddc-225d4b7b81f6	lotto6	688	2012-08-27	{9,12,16,33,34,35}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bf7099a7-8eef-4537-9683-80ea59c398f9	lotto6	689	2012-08-30	{6,8,12,17,24,31}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1bb3af72-3c54-41b6-894e-e03c01a05b6a	lotto6	690	2012-09-03	{7,8,10,21,34,38}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f763fc64-50d2-4f74-9e80-6abb4632ab73	lotto6	691	2012-09-06	{4,7,8,15,16,42}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ad6506dc-f60c-4f5f-9bc3-4fbbb6d2d80c	lotto6	692	2012-09-10	{9,10,12,19,21,42}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9870cd15-cfe1-46a4-9ab2-d771ed02226a	lotto6	693	2012-09-13	{4,14,18,22,32,35}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
57338a6b-a0ab-44ec-b889-03ffd5ad5189	lotto6	694	2012-09-17	{8,23,27,31,38,40}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
16eb1fb2-cb4f-4956-8bd0-7622d18b60a6	lotto6	695	2012-09-20	{4,7,11,12,13,19}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c0dab2cc-d1b7-4f6a-a7b9-1f5e3a60ecfb	lotto6	696	2012-09-24	{2,10,14,19,36,39}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
781261c1-c5b4-459f-b232-5469b7ee5cb1	lotto6	697	2012-09-27	{2,12,14,18,40,41}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
df045548-0af6-4b87-8130-7700431edeba	lotto6	698	2012-10-01	{5,20,21,26,30,33}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
12c13e01-c685-490c-aed1-4726d5b4e1e7	lotto6	699	2012-10-04	{12,13,21,25,29,32}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
841647ab-186c-426c-b38a-21046049988f	lotto6	700	2012-10-08	{1,8,17,24,33,35}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0a620ca6-8208-4100-80b7-a09d62d9f288	lotto6	701	2012-10-11	{20,22,24,32,36,39}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ed9a1ad6-065f-4029-b5bc-f3ab825f6592	lotto6	702	2012-10-15	{1,20,23,37,38,40}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
10583ff7-888a-4985-81f0-6e6b35561ba5	lotto6	703	2012-10-18	{20,24,27,28,38,41}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
824a037f-bd4e-46d5-9786-cd125a2c48e1	lotto6	704	2012-10-22	{7,10,16,18,19,37}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0e77a931-eb1b-4dcd-8683-22e5321c856d	lotto6	705	2012-10-25	{14,15,16,18,20,33}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a1db998e-1052-4c54-9fb8-21b424ce7329	lotto6	706	2012-10-29	{2,8,29,31,34,37}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ea034958-6a7d-4654-9744-180220bb4769	lotto6	707	2012-11-01	{8,15,21,32,40,41}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5a2df9c7-7c21-4b80-ba3c-b6ee43004297	lotto6	708	2012-11-05	{2,13,20,22,25,38}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2d172697-2b3f-492d-bfba-28b5922570b3	lotto6	709	2012-11-08	{1,11,13,29,37,39}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1e23655e-1b93-407d-855d-3471f7ffd55c	lotto6	710	2012-11-12	{4,5,9,20,33,37}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ad2c123e-f569-405a-bc02-b6e8985784df	lotto6	711	2012-11-15	{5,11,15,24,34,39}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d4fa09f5-7566-4d88-a314-b678afd8b762	lotto6	712	2012-11-19	{2,5,8,9,14,25}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6127158f-edbf-4541-949e-5150cac4f17d	lotto6	713	2012-11-22	{19,20,21,24,25,26}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5397f224-8b6c-4c11-9255-e8dc8930c0f0	lotto6	714	2012-11-26	{2,14,26,28,29,42}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c3a315fe-77f1-4186-aa9b-974b949de714	lotto6	715	2012-11-29	{5,10,12,25,28,31}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bc7d7f31-df04-4f39-9315-0b91f73c03ee	lotto6	716	2012-12-03	{5,7,14,24,25,35}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b8a8db4a-3a0f-45b4-90df-f6aa09b7a8bc	lotto6	717	2012-12-06	{13,14,16,21,29,42}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
21a5e144-280c-407f-b9ad-38a1f1e7e825	lotto6	718	2012-12-10	{15,20,27,29,33,43}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c033ded5-c22c-450f-91df-c1bd916950d3	lotto6	719	2012-12-13	{11,14,27,31,34,42}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d9d32bba-af9b-4e2c-aa22-19bd01cf2346	lotto6	720	2012-12-17	{25,26,27,28,35,38}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
76c4c942-1ac1-4044-a112-758ec1103c7a	lotto6	721	2012-12-20	{1,14,23,24,27,40}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ca4b14a0-d79c-4949-b627-f1041ea41fd5	lotto6	722	2012-12-24	{6,11,32,34,35,39}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
76b4e084-2ef8-49ca-9793-a6bbb72c9a10	lotto6	723	2012-12-27	{16,27,28,36,39,42}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
78a86fbe-6043-4cd1-9a0b-94f28e2fcf66	lotto6	724	2013-01-07	{4,9,32,37,38,39}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2e0c150d-d661-4022-aeb7-90d4aa90acda	lotto6	725	2013-01-10	{5,6,7,20,31,41}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
af1fff02-4038-408d-81d5-bd842643c689	lotto6	726	2013-01-14	{13,21,30,31,37,40}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1ec51a33-0f3a-41ec-a963-16edc5c293d8	lotto6	727	2013-01-17	{3,24,26,27,39,41}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c7febc9a-714f-47ab-99cf-cfa4fff94134	lotto6	728	2013-01-21	{10,15,22,23,38,42}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9a490374-2129-491c-8a52-295ffa072b31	lotto6	729	2013-01-24	{2,10,16,18,27,42}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a1abdf86-acab-4f27-b201-fca82f7c5c21	lotto6	730	2013-01-28	{10,15,21,22,33,35}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
870a24b5-fe18-4604-9211-bef514b38b06	lotto6	731	2013-01-31	{6,7,23,25,38,42}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1f6372ae-c08d-44f6-895c-5bf14ded268d	lotto6	732	2013-02-04	{20,33,35,36,37,38}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
34c9f450-d1e1-4706-971a-029c582ac64c	lotto6	733	2013-02-07	{5,13,14,26,37,38}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e2e4a92c-447f-4614-9d06-23658a685ba0	lotto6	734	2013-02-11	{10,19,22,27,29,39}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e5a8f942-42c2-4614-94f1-0c3c6880e998	lotto6	735	2013-02-14	{5,12,19,22,32,39}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ce5e09d1-2cd2-4a56-9c6f-c4b100f7b108	lotto6	736	2013-02-18	{2,14,17,19,38,43}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0896c34d-1b97-45e3-bbc2-dd79552be048	lotto6	737	2013-02-21	{6,10,21,24,27,39}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7827ebb8-f872-4890-a99c-b497066db0ef	lotto6	738	2013-02-25	{14,21,22,32,33,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
990a74a8-9bda-411d-bc54-0fcaf803bb1a	lotto6	739	2013-02-28	{11,13,18,20,28,38}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
45f15039-b1bb-44b7-b520-a3eab318963d	lotto6	740	2013-03-04	{8,9,15,26,37,40}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
84050190-b045-4df8-ba46-3006b89aa311	lotto6	741	2013-03-07	{8,11,15,29,36,43}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
50896099-a182-41e1-8119-4d148388a8b0	lotto6	742	2013-03-11	{2,12,13,14,22,35}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b02cf58f-7fc0-4dbd-984e-a228c4822ac0	lotto6	743	2013-03-14	{3,4,8,10,14,37}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e328c6da-ebc0-4013-94f2-37d9732444f3	lotto6	744	2013-03-18	{2,5,12,14,30,42}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3aea61f8-e464-4c28-bad5-bb4532cf3b4c	lotto6	745	2013-03-21	{8,12,16,23,33,34}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
65ae42f7-2425-4637-a1ee-64e02b1486d7	lotto6	746	2013-03-25	{6,9,10,29,31,35}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
560fe43e-8c01-42b8-82db-706dd938705e	lotto6	747	2013-03-28	{8,19,20,23,24,35}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d5732239-96ca-41fd-896e-e1125fed1ea1	lotto6	748	2013-04-01	{2,14,16,27,28,30}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8b1daa64-f9a4-4825-a2de-80f587a76e9b	lotto6	749	2013-04-04	{7,8,11,13,23,40}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fc4217f8-242e-4515-856d-f3ecc7588fe9	lotto6	750	2013-04-08	{4,6,13,16,18,39}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8a8ed962-ed68-4905-9d7a-518de855b68c	lotto6	751	2013-04-11	{13,16,21,25,31,38}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b04e4de9-8108-4a03-abbc-1aef06c66d56	lotto6	752	2013-04-15	{3,5,13,18,22,37}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
78c9bba5-7f25-4039-883b-97875103637a	lotto6	753	2013-04-18	{2,4,11,15,20,38}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
00707ac7-8f8b-4d05-b731-7f524bfbf376	lotto6	754	2013-04-22	{16,27,33,35,39,41}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d1ef4160-f3dd-4325-9511-e43e6f69c8e4	lotto6	755	2013-04-25	{10,16,20,25,29,39}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
93b779aa-79b4-4089-acf7-80156ba65938	lotto6	756	2013-04-29	{8,10,24,26,27,28}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fa79feb5-dd7f-49dc-84ee-0ba9f38524b4	lotto6	757	2013-05-02	{4,10,14,19,35,38}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bd398de7-026c-4876-bbc5-3f8763742100	lotto6	758	2013-05-06	{11,19,20,25,38,40}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bb2a8da6-b00a-4c4f-bfe2-0c250b9c7c76	lotto6	759	2013-05-09	{14,22,25,28,37,41}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
17a48912-7a64-45d5-b2a7-d9a96b2f5fb3	lotto6	760	2013-05-13	{3,4,6,15,32,40}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7dca6ba0-b1e6-4e70-b0d6-798e9c523213	lotto6	761	2013-05-16	{8,10,11,12,20,40}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
975f05e9-7e24-42b8-8773-affe7f2882d8	lotto6	762	2013-05-20	{6,8,9,20,24,27}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c2c9116a-748d-4e49-92c8-15712fdcd584	lotto6	763	2013-05-23	{6,8,10,21,39,42}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4ad23173-fa17-491a-bdbf-5ab81225212c	lotto6	764	2013-05-27	{6,7,24,34,42,43}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7080477e-795c-4790-9634-59be1ce4762d	lotto6	765	2013-05-30	{4,14,17,22,26,41}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
06071ae1-c930-4a9a-9d09-c373c43833b4	lotto6	766	2013-06-03	{6,10,12,32,37,39}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ad230b39-8f91-4d0f-9c65-d7178c13d13c	lotto6	767	2013-06-06	{2,6,11,27,29,37}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
488077db-a1c8-4605-a846-2718d1cfa2ef	lotto6	768	2013-06-10	{1,8,19,25,32,38}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
57420ac5-f603-4518-a698-0c1a29265e1b	lotto6	769	2013-06-13	{1,2,4,16,17,38}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c1e600e5-6902-4b93-aec6-066b3012836f	lotto6	770	2013-06-17	{17,19,21,22,36,37}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ddddd1b1-361f-475c-826f-7a07ee1e2b86	lotto6	771	2013-06-20	{15,21,31,32,33,34}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4ea34be6-89fc-4375-ada1-29c896ecbdce	lotto6	772	2013-06-24	{7,11,16,19,20,23}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
92f5bf32-ac98-43a9-901b-0dc626903b71	lotto6	773	2013-06-27	{4,7,10,11,12,32}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ee69728c-f1bc-450b-9f3c-0c2a32ae086d	lotto6	774	2013-07-01	{2,4,9,13,16,33}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9e702b5f-46a2-4fc9-b462-6ab7686aca6a	lotto6	775	2013-07-04	{1,2,21,22,37,38}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6ed3c1f4-efb9-4457-9201-9e4e95b30589	lotto6	776	2013-07-08	{2,8,14,23,28,42}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b965bbdd-c806-4fbc-b05b-83d4bda29188	lotto6	777	2013-07-11	{15,16,23,29,37,39}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8673d72e-a6a2-46f0-ab1d-3a1d4817dfa7	lotto6	778	2013-07-15	{5,11,17,24,35,41}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
93651082-7767-4d27-8227-090cbd129e1e	lotto6	779	2013-07-18	{10,13,27,34,36,39}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0fa43d6c-5aa6-448b-922c-03279b0d2112	lotto6	780	2013-07-22	{6,7,12,26,39,43}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
780938d0-a20d-4f91-9b9e-8cbb18dc1d5a	lotto6	781	2013-07-25	{5,6,15,23,40,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f6f85498-c61f-4452-8b27-9a54e6d76163	lotto6	782	2013-07-29	{19,21,23,24,27,43}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
aa7beecf-92e3-400e-86bc-165e10113213	lotto6	783	2013-08-01	{9,14,22,24,25,32}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3857176e-318b-4747-840d-eec0ee219e58	lotto6	784	2013-08-05	{1,9,23,29,37,41}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
296bffb2-bad8-4bce-a2e3-b3d3ddfd3168	lotto6	785	2013-08-08	{1,9,18,20,24,29}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
10eea114-0010-4ac1-83a4-e6a32b4d75f4	lotto6	786	2013-08-12	{10,11,17,31,35,39}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
913e7be1-9eef-46c4-9955-80ceeb9dd794	lotto6	787	2013-08-15	{4,5,13,21,33,34}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9c1a80ae-07f1-48a2-b733-6dea13e917a3	lotto6	788	2013-08-19	{2,8,13,27,31,32}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6d0e11d9-9116-4d92-9253-5d3d032ef8ee	lotto6	789	2013-08-22	{12,17,29,32,38,40}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
531a3940-d03f-4b4d-82d5-e714ef243da3	lotto6	790	2013-08-26	{9,13,19,27,34,38}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a5464cef-138d-4742-aa90-0872884307ca	lotto6	791	2013-08-29	{1,10,22,24,34,37}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
67d5c596-2f3f-4888-94a8-e655765cee98	lotto6	792	2013-09-02	{1,7,14,25,37,43}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
72fdafe2-a107-469a-8624-fcea544a96ed	lotto6	793	2013-09-05	{10,13,14,19,26,43}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
431c5a57-28df-4223-abdc-c5f774f10fa3	lotto6	794	2013-09-09	{15,22,25,29,34,42}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1d056966-3978-4da0-8da4-b838a034781b	lotto6	795	2013-09-12	{13,19,24,28,33,38}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
34eabc03-f03d-4fa0-b824-6b3ae607abf4	lotto6	796	2013-09-16	{1,7,11,14,22,34}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7bbf1a75-6ad0-4fe1-a1a5-ad7f3665f430	lotto6	797	2013-09-19	{1,4,13,18,23,39}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4e419a4e-c9f9-4816-afce-b2ad38f911f6	lotto6	798	2013-09-23	{1,3,5,25,39,41}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5dc23514-5421-42e2-bfe1-710a449432ca	lotto6	799	2013-09-26	{4,6,8,10,19,28}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4a24eb20-e27c-4467-a47c-eae102e1c272	lotto6	800	2013-09-30	{8,12,22,23,25,35}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
74c5f490-804c-41c3-875a-a7d4f9a974c2	lotto6	801	2013-10-03	{2,18,19,20,25,31}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
872c5426-112c-474c-9fdf-f3a208211826	lotto6	802	2013-10-07	{9,13,18,19,25,30}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7164ce65-87f0-4a9d-bc73-61516f9fad1a	lotto6	803	2013-10-10	{9,29,33,34,35,41}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
36018e30-8776-44fd-b5b6-195e7246f167	lotto6	804	2013-10-14	{6,20,23,25,31,33}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
339dc5f5-961a-4ae6-a5f5-b52c75346af3	lotto6	805	2013-10-17	{2,14,19,22,24,43}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5c653f7b-bd2e-49ca-b57c-0cce1aa94d25	lotto6	806	2013-10-21	{3,16,19,25,39,40}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
adc95a28-7c77-4b63-9eb1-e06872ed18e5	lotto6	807	2013-10-24	{1,6,12,20,22,23}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d9a8ed1a-29d4-40cf-b6a7-ed1b35d5f96c	lotto6	808	2013-10-28	{13,18,22,28,41,42}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fd6ebbb1-4f26-4b14-a62c-9df2de27eb38	lotto6	809	2013-10-31	{2,11,20,31,32,37}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7a29a945-33b2-49c6-b007-0c5f9d7daf69	lotto6	810	2013-11-04	{3,31,32,38,39,40}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ed59948c-7f4c-4845-9c3e-c7255f425095	lotto6	811	2013-11-07	{2,6,20,24,31,40}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
99c6bacf-8bac-4532-b628-a25f8d5de333	lotto6	812	2013-11-11	{1,12,15,26,34,40}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
52057949-ed6c-4b16-8ae5-e5f88b405998	lotto6	813	2013-11-14	{9,10,12,13,28,38}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2a73114f-6c66-4acc-83db-96e30a3984f9	lotto6	814	2013-11-18	{4,7,15,23,38,42}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b9d32195-c885-4c73-8c9b-91e542e8b290	lotto6	815	2013-11-21	{1,2,6,24,25,41}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b311d7c6-286e-400e-8725-16fe36573050	lotto6	816	2013-11-25	{5,14,19,24,27,37}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
98d4fe54-eb87-49f7-91d5-ff28d21b9895	lotto6	817	2013-11-28	{16,21,27,32,34,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fb8eb2ed-11e5-423f-92c6-e20c697a8ed7	lotto6	818	2013-12-02	{5,21,24,34,37,38}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
31e379c7-8d78-41b3-8091-e7a0aeadc135	lotto6	819	2013-12-05	{10,19,23,25,30,40}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e6d27161-1ec6-4b77-b348-ee138abf2264	lotto6	820	2013-12-09	{1,11,19,28,39,43}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
22132af7-dc4e-4cd3-ac4a-b88e995f9dd1	lotto6	821	2013-12-12	{7,10,12,34,40,43}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
23dd837f-f500-4528-9156-224f28a7ae76	lotto6	822	2013-12-16	{6,11,15,24,27,33}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4f30607a-a403-4353-a13f-b141d5a09a30	lotto6	823	2013-12-19	{5,6,23,30,37,38}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
776637ed-d5c3-4201-bad9-d4b890a1122d	lotto6	824	2013-12-23	{16,19,26,27,29,32}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5585952a-cde0-4677-91eb-891bc4b785a5	lotto6	825	2013-12-26	{6,10,12,16,39,40}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d1cb8d0f-6187-4eea-b37c-5924d441d1a6	lotto6	826	2013-12-30	{5,15,22,24,29,36}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
96e8eb98-cdff-4ab7-be23-78bfd6f25de9	lotto6	827	2014-01-06	{2,4,23,24,33,41}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c1ef54cd-85c6-4a98-9877-8555ec3b584e	lotto6	828	2014-01-09	{2,9,10,24,25,43}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8321069f-e643-40e6-a60e-84c397764f83	lotto6	829	2014-01-13	{2,3,23,32,36,39}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8b2e12b7-1701-481d-b0e2-920661957452	lotto6	830	2014-01-16	{5,6,9,18,28,40}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
44599f01-4ac2-44ef-b5e3-fddfd24d14df	lotto6	831	2014-01-20	{3,4,7,13,22,31}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
389c77b5-02bb-4c8d-9542-f62a3137c6b5	lotto6	832	2014-01-23	{19,24,27,31,32,33}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4b2d9abe-94ed-4cc1-9e7a-18a7f0e924f3	lotto6	833	2014-01-27	{5,6,13,20,22,28}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bf79d022-378b-47a2-ba2e-7fb31558edb2	lotto6	834	2014-01-30	{4,17,27,39,41,42}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
826f37ca-b95f-4bca-a2e5-20b93490241f	lotto6	835	2014-02-03	{5,9,10,28,39,40}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
209ccf19-618e-425d-b6fd-8ab23dd3ff23	lotto6	836	2014-02-06	{7,11,31,34,38,43}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
707d0f2d-c83e-48ac-ab6a-d08c70c99064	lotto6	837	2014-02-10	{5,17,34,37,39,42}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
52f07557-3a18-4bc6-b689-01d0bd48f494	lotto6	838	2014-02-13	{12,28,32,36,38,43}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
53503a05-f7e8-4716-8013-4cfdbdeae0c3	lotto6	839	2014-02-17	{1,3,5,12,13,38}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a58a7c14-9057-4823-9461-dc2fa0ef029d	lotto6	840	2014-02-20	{3,4,17,24,27,34}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
78db4c5b-a71b-40bf-a4ec-a765acebea1f	lotto6	841	2014-02-24	{8,22,24,28,31,36}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ebe713ab-2efa-485d-bb85-f1e223b79f23	lotto6	842	2014-02-27	{8,11,17,26,33,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6e65a51f-4677-4864-9919-38e7d163b327	lotto6	843	2014-03-03	{3,7,8,26,42,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
03a3e7ff-c4b2-40fc-9bbd-c8c498f9f497	lotto6	844	2014-03-06	{2,5,18,27,35,38}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e3217686-4a76-4084-a5eb-495e29749224	lotto6	845	2014-03-10	{2,12,13,22,24,34}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
273d9a84-1233-45a7-a927-ed8bae49d26f	lotto6	846	2014-03-13	{9,14,18,28,30,33}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cbfbee50-d5db-4e5c-a6f3-01ba8f4902c4	lotto6	847	2014-03-17	{9,10,23,31,35,36}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3ab8162d-9907-4a65-8261-f20e9b753795	lotto6	848	2014-03-20	{6,7,13,15,35,39}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1960cfee-1b4b-44d2-a8a0-1189cb5fe85c	lotto6	849	2014-03-24	{1,3,4,10,15,40}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
eb3b5cbc-8ec8-49d5-a3a3-e1b82ade504e	lotto6	850	2014-03-27	{2,11,30,32,38,41}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0a8546f4-c0d0-4ef2-be39-cdb998fa09af	lotto6	851	2014-03-31	{5,8,14,20,26,27}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1dac16b1-4adb-41f2-ad64-c2fcb35faf2b	lotto6	852	2014-04-03	{3,17,22,23,27,40}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2b8b9a02-819b-4b7f-9e5d-27c0f4b0d9a2	lotto6	853	2014-04-07	{2,9,22,26,31,35}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
09ad6937-f40d-4402-add0-378bf8493154	lotto6	854	2014-04-10	{4,11,14,18,25,37}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
86f726e6-36e0-4c06-8e31-fbcec853055e	lotto6	855	2014-04-14	{10,13,15,25,37,42}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6126ac0b-6176-40f8-8091-2d0822cbafec	lotto6	856	2014-04-17	{10,24,32,34,38,40}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d00715c8-08dc-4fd8-88de-60a182c28b29	lotto6	857	2014-04-21	{1,3,6,17,28,42}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
669403bf-73fe-4295-9aed-cf9bc6de2aba	lotto6	858	2014-04-24	{3,14,29,32,33,42}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5be4ce3d-2cc8-4f78-aa83-e6bb7a10a265	lotto6	859	2014-04-28	{1,12,15,17,21,36}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
41b11c51-2c9c-47b4-b2ae-12950e0ca891	lotto6	860	2014-05-01	{14,16,32,35,38,41}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3bb9caeb-a5f0-4d6c-adc7-64f19aadb428	lotto6	861	2014-05-05	{4,17,21,28,35,42}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
eb563591-48df-4146-b41c-07f338695599	lotto6	862	2014-05-08	{5,10,16,34,36,39}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ea82c858-1ae2-4f61-ba57-b9a553773266	lotto6	863	2014-05-12	{4,14,18,26,35,36}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d2b7cd65-6a83-4316-9714-2fa26a759b54	lotto6	864	2014-05-15	{19,21,24,28,32,40}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cee82881-0b42-4806-8669-efa9b596745e	lotto6	865	2014-05-19	{5,7,8,12,23,25}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cfc7fbb8-a205-4303-9c94-545b47b61fda	lotto6	866	2014-05-22	{1,3,10,21,29,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ca9b8e29-5fc0-48d7-9e15-d8a8f6ab3561	lotto6	867	2014-05-26	{2,14,21,26,37,38}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3c5df319-e5e3-496d-b6d1-f93369ec479d	lotto6	868	2014-05-29	{5,18,19,26,31,43}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
09d8ef54-165d-4724-8823-d21ac657c3af	lotto6	869	2014-06-02	{5,7,23,24,37,38}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6156718d-64bc-44be-8437-da883016605f	lotto6	870	2014-06-05	{1,11,14,21,23,39}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7277d635-d1b8-466e-a655-0c0094f99572	lotto6	871	2014-06-09	{3,10,11,13,20,27}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ef4c857e-a891-4596-ac32-80851aa68164	lotto6	872	2014-06-12	{6,10,17,18,19,24}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c96e35d8-e2cd-4b57-ad2b-2e07a1c58783	lotto6	873	2014-06-16	{4,22,26,27,32,43}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
da8a3001-7691-47e6-8b8c-727bb8b88dd7	lotto6	874	2014-06-19	{2,8,21,27,33,37}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
394c1385-e7a1-4170-95ad-543bed931844	lotto6	875	2014-06-23	{4,5,11,13,22,25}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b98174d1-2a1f-4504-bdec-44cafa1576c6	lotto6	876	2014-06-26	{11,12,18,25,35,39}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
caf213b4-e76e-470f-b9cd-7b34d779abab	lotto6	877	2014-06-30	{3,14,17,32,35,43}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3407de2a-c667-4e97-a5b0-cbe4bc6b336a	lotto6	878	2014-07-03	{5,14,16,22,25,40}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
26a72b94-8136-4aaf-a7f4-24ef58459bdc	lotto6	879	2014-07-07	{24,27,34,35,36,43}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
63534b76-31cc-4199-9bd9-b20bc2178cb8	lotto6	880	2014-07-10	{1,8,11,16,25,32}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0a05efbf-c0b3-44ab-8d3c-6a181bad20f5	lotto6	881	2014-07-14	{4,6,12,18,28,41}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6e976918-ca65-4e94-a8a9-b2db7e6fad1b	lotto6	882	2014-07-17	{5,15,23,26,30,36}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ba62f584-f915-41e5-8b7e-409320c7e7c6	lotto6	883	2014-07-21	{10,16,25,29,38,42}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0240e764-3bff-484e-b2e3-2c357bbb2c15	lotto6	884	2014-07-24	{2,7,25,26,38,42}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2658b4a9-b9af-47ae-aeeb-b7cd9bad4a64	lotto6	885	2014-07-28	{22,28,33,36,37,41}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
09ca9d8c-e121-4cf4-817a-650a39b3b441	lotto6	886	2014-07-31	{7,10,13,23,34,39}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
80514c05-a03a-4291-8462-9382533796ba	lotto6	887	2014-08-04	{3,4,6,18,32,37}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3ae0d641-e0bb-492a-81cb-7e86f7f37fd3	lotto6	888	2014-08-07	{2,4,9,36,37,39}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a1f86352-7b10-40e3-820a-26aeb9236e54	lotto6	889	2014-08-11	{2,10,21,28,41,43}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
02800c65-9bd6-429f-aec7-a39790731f66	lotto6	890	2014-08-14	{1,4,6,14,28,31}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
803c0cd9-8178-4d88-bb2b-6269cd4fe70d	lotto6	891	2014-08-18	{7,9,14,30,42,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a82d5d4e-3886-4cef-bfa6-100a0ca1156f	lotto6	892	2014-08-21	{14,19,31,35,40,43}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
069bb025-58c0-4241-966b-f514b8529496	lotto6	893	2014-08-25	{10,12,26,28,29,37}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c2e0fab1-f941-497a-8e4e-7888ee7df440	lotto6	894	2014-08-28	{4,5,9,20,21,32}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a01812b3-ecff-4d90-a08d-fd41f2f87f33	lotto6	895	2014-09-01	{5,12,24,25,37,38}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5ab2332e-c4b9-441d-8d91-808bff6f3282	lotto6	896	2014-09-04	{5,6,21,27,32,38}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
caebf6e9-e94d-4c57-9e3a-483c9a9cc544	lotto6	897	2014-09-08	{8,10,14,15,27,30}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
66dd459f-f7e2-4df7-9c6f-223f9fc9729a	lotto6	898	2014-09-11	{13,17,21,25,29,37}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d5afc6c5-d9f0-471f-a619-0ffbd43d9041	lotto6	899	2014-09-15	{3,10,15,18,27,40}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c5fa14f3-41aa-4084-9133-4ae7a9410ca2	lotto6	900	2014-09-18	{8,12,21,22,31,35}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
afb013c6-f531-43bd-8e7a-c1a70ea33ac7	lotto6	901	2014-09-22	{6,13,22,28,29,37}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7ad75baa-016d-432d-8b4f-a33ade8a90ff	lotto6	902	2014-09-25	{11,21,26,31,32,33}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
49779d7f-721e-4fc5-b4ec-44a82d278df3	lotto6	903	2014-09-29	{1,3,6,7,16,19}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
844ce1c1-2d6f-4b4d-b50c-d92873b6583a	lotto6	904	2014-10-02	{2,4,6,15,21,41}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d36b0587-a4d1-4c44-9361-e439e77cd5a6	lotto6	905	2014-10-06	{4,15,24,40,41,42}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f8996fca-ab79-4a3c-b0e8-b4fa08029313	lotto6	906	2014-10-09	{6,9,12,13,30,40}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c5e77a8c-d7ff-4dcd-8a6a-f47e04428abf	lotto6	907	2014-10-13	{5,13,18,22,27,41}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
306ff449-0331-4699-bfcd-13559bb61dcd	lotto6	908	2014-10-16	{6,14,21,22,23,30}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
28d8a3bc-379c-4258-95a9-7ba3adb7c56d	lotto6	909	2014-10-20	{12,15,21,27,30,35}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2afc94d8-fb81-4028-a17d-dd8b584c466d	lotto6	910	2014-10-23	{11,12,13,17,25,33}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3fa406ef-1fc7-4538-8ed9-3e6735c01b31	lotto6	911	2014-10-27	{8,16,18,22,27,35}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
07e763e6-b952-4b14-90aa-b6ccc34f3f58	lotto6	912	2014-10-30	{5,14,19,20,32,42}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
58b3316f-5314-4180-9c31-d40227c64f79	lotto6	913	2014-11-03	{5,8,20,31,36,41}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d916feb8-3a42-46f2-adc9-4702c94d4c1e	lotto6	914	2014-11-06	{2,3,26,33,36,40}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d9864bcb-ed3a-43a9-b99f-69a65b7b4213	lotto6	915	2014-11-10	{7,12,21,33,38,40}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8761a995-871c-4197-812e-af9a7a8ab6ee	lotto6	916	2014-11-13	{6,14,25,27,38,43}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
0e6123d4-5b8b-4b31-915f-375826c9fd32	lotto6	917	2014-11-17	{2,6,25,26,41,42}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b7d7901b-504b-48e6-87c2-04fe60429bcf	lotto6	918	2014-11-20	{10,15,25,29,34,36}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f0f163e4-0a0d-4eb2-b83e-a651f2da239f	lotto6	919	2014-11-24	{2,9,12,17,33,42}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
52ece83b-96e6-44f9-817b-3f0e7b157af9	lotto6	920	2014-11-27	{9,17,27,30,35,38}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4c114ad6-8866-422d-846a-aff6ec1ad1ba	lotto6	921	2014-12-01	{5,7,26,36,38,39}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
17c503ad-5488-49a7-a6f0-5bd56c7f84e2	lotto6	922	2014-12-04	{4,6,19,32,33,38}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c408e256-3b2e-49f3-ac81-986d32e13921	lotto6	923	2014-12-08	{5,13,30,31,32,35}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
54633607-2ac6-4e6f-8117-6f699a72d840	lotto6	924	2014-12-11	{13,20,24,32,35,42}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
269fed51-e30b-4c93-95c4-2018af807ad0	lotto6	925	2014-12-15	{25,26,27,28,32,37}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
78b3b920-9160-4125-b403-dc3852573b81	lotto6	926	2014-12-18	{16,26,32,35,37,39}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
262744c0-30cf-4bad-8166-62d11e3b8df7	lotto6	927	2014-12-22	{2,29,30,31,33,34}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9e0ecca5-ec68-437d-9902-d2f98b281076	lotto6	928	2014-12-25	{1,21,23,26,31,33}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4c7a571b-c7cd-4081-bf24-f019af7d9ac8	lotto6	929	2014-12-29	{10,12,15,25,31,34}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
523e8819-2b7d-4f35-8a34-ff9a3469e0ca	lotto6	930	2015-01-05	{10,12,37,39,40,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a73a66aa-7121-45aa-a571-4338ed26a095	lotto6	931	2015-01-08	{14,18,19,24,25,33}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
88b050e7-a324-498e-8b72-561f82c75ff9	lotto6	932	2015-01-12	{4,15,30,37,42,43}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b545460c-0c07-4038-b71b-d6f46e8a3f34	lotto6	933	2015-01-15	{5,9,20,21,31,41}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fbb8f8b0-444a-4c01-a00d-c63f4eec84b5	lotto6	934	2015-01-19	{3,7,16,17,20,32}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
41179eb5-a0a5-4833-b9a8-f9ff80cf2397	lotto6	935	2015-01-22	{2,12,14,26,38,43}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
52ca90b1-04f4-462d-ac0e-dc13963f1787	lotto6	936	2015-01-26	{1,3,12,16,20,35}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
17f004cd-1205-4ff2-a102-85d8e9449fde	lotto6	937	2015-01-29	{13,15,21,25,36,41}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b197ca1b-e201-4b99-a663-5216cca8a115	lotto6	938	2015-02-02	{5,9,12,19,30,35}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
95315325-162a-4b76-9cdb-096d4211e8cc	lotto6	939	2015-02-05	{8,11,15,17,26,43}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
556190de-b8e8-4568-ba72-1962875c171f	lotto6	940	2015-02-09	{1,18,28,31,35,37}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e7d4c238-48d5-40f2-9ded-0c69e7e47664	lotto6	941	2015-02-12	{5,12,22,29,38,39}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
28d75648-7214-47a1-aaae-c50c680d1104	lotto6	942	2015-02-16	{2,3,14,27,28,38}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fed41f91-e227-4d06-a5ee-97f297a5ec55	lotto6	943	2015-02-19	{9,10,14,15,39,43}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9e59af86-5b54-42e3-931c-a2347d3d8e5b	lotto6	944	2015-02-23	{7,20,25,29,33,37}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1ee11a61-d3e7-4481-a55b-f60483d9bb86	lotto6	945	2015-02-26	{3,10,15,23,36,37}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
c7952aea-02f6-4fd9-8548-3c3ff8ba4948	lotto6	946	2015-03-02	{2,9,12,16,31,36}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a0cb5452-7242-458b-a6bd-3ebf73359f8e	lotto6	947	2015-03-05	{1,6,21,23,27,40}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
22cf170a-7737-457f-8652-e897bca7aa98	lotto6	948	2015-03-09	{7,16,17,28,39,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
cc8b8b11-e101-4805-b829-99f0f9d7fbd2	lotto6	949	2015-03-12	{5,19,26,36,39,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
4cb30ba5-37bb-4396-8d5e-bd0a4633859e	lotto6	950	2015-03-16	{2,6,16,24,30,41}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d155b3ef-9cc6-49a7-b939-532363252b40	lotto6	951	2015-03-19	{11,15,22,23,26,30}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1ffe072b-9e30-4dad-9beb-fd4200ee06dd	lotto6	952	2015-03-23	{10,16,22,25,31,39}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
a05b678e-1f48-4810-9079-2e231331e0d2	lotto6	953	2015-03-26	{2,9,17,38,39,42}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1f03139a-51e5-4409-8223-d4cf1399d6b6	lotto6	954	2015-03-30	{3,23,24,28,29,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
5e138f83-18d0-40d5-b0a7-8fbc7e975f0f	lotto6	955	2015-04-02	{14,19,27,28,37,42}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2852b405-599c-446a-a632-44705e84ac94	lotto6	956	2015-04-06	{1,4,6,22,24,38}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8c9f7267-489e-42d5-93f2-c5a7ee880a95	lotto6	957	2015-04-09	{2,11,22,32,36,42}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e6e8c08d-831f-461a-a533-fb6be5fa1be7	lotto6	958	2015-04-13	{9,18,23,24,26,30}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e6bb09d1-704d-4679-86af-6a381d3dab23	lotto6	959	2015-04-16	{1,16,18,28,36,38}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
172cf30c-a934-4688-a173-c53b7232ca72	lotto6	960	2015-04-20	{5,18,23,32,35,39}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d71f9074-4f0a-4672-ab1c-0f73cb598858	lotto6	961	2015-04-23	{5,11,17,18,19,25}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
2b8c6239-5d1c-407a-bc4f-6d7d4c481201	lotto6	962	2015-04-27	{4,6,10,24,32,37}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
53366f0c-31e4-40f8-8ad1-7728aad93a09	lotto6	963	2015-04-30	{4,23,29,31,32,35}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
dbb82413-d1df-4233-bc3b-e2cf6dc5d237	lotto6	964	2015-05-04	{2,21,23,29,30,43}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
3f81f787-4c21-41ae-912f-f388fe2e688b	lotto6	965	2015-05-07	{10,12,19,20,21,22}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
80f18a4d-be75-4754-a1a6-554dd38dabee	lotto6	966	2015-05-11	{10,22,31,34,36,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
917adcfa-7d18-443e-b8e2-2bbe6296b731	lotto6	967	2015-05-14	{1,11,26,30,32,40}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ced31d36-79e9-4830-9873-7b8e8f47d317	lotto6	968	2015-05-18	{6,10,15,20,23,26}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
afacf51a-6bd3-4015-adf9-03186a0dd73e	lotto6	969	2015-05-21	{3,9,19,22,23,40}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
959517df-8fa8-4462-a561-a3b23eaa2caf	lotto6	970	2015-05-25	{2,4,18,23,31,38}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ebedb7d5-1a6b-4c0e-9d42-8fbeed435134	lotto6	971	2015-05-28	{2,3,4,12,22,29}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e7b6f38e-b5cf-4f46-9007-2e515d23f25a	lotto6	972	2015-06-01	{2,7,17,18,21,40}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
05f5d2ce-e8be-4aac-b414-c043ce07f0bc	lotto6	973	2015-06-04	{1,5,6,12,30,31}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
1599a84e-a219-4213-8782-48932cf977c1	lotto6	974	2015-06-08	{2,3,29,30,32,43}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
bfb06e32-69a2-41c2-aded-1c81a3b016f8	lotto6	975	2015-06-11	{3,11,13,27,29,36}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
85664e1c-7dde-46e9-a9ed-38d69e61712b	lotto6	976	2015-06-15	{6,13,22,28,42,43}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
49880e06-ec14-493f-95d8-1febe6fed538	lotto6	977	2015-06-18	{10,15,17,27,42,43}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
e641b073-6aca-48e6-a688-919b6dbb4111	lotto6	978	2015-06-22	{3,11,19,30,38,42}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8d97f674-7cc6-4e22-9a9a-563706782727	lotto6	979	2015-06-25	{9,12,16,18,27,38}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ca3f0c76-8d46-4d10-84cf-cd06bd5bd0ad	lotto6	980	2015-06-29	{15,20,23,35,38,42}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
6aa169d8-48a7-4adc-a94c-39ac24c3c2f8	lotto6	981	2015-07-02	{14,19,22,23,31,37}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
90068551-e7a2-43d6-8f4c-28635a723999	lotto6	982	2015-07-06	{15,19,21,22,29,40}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
ce85c2b3-3f8a-4760-8f5e-d7874e77489e	lotto6	983	2015-07-09	{15,19,32,35,36,38}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
81084fbd-b689-4a7e-afb4-e0b8b2d96463	lotto6	984	2015-07-13	{14,23,24,28,37,38}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
eebf12e3-3d99-40a3-8931-2222a0d5d801	lotto6	985	2015-07-16	{3,11,19,26,29,38}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
b0f3a0c2-fe28-418d-9a16-758b7fad8f79	lotto6	986	2015-07-20	{4,11,17,30,36,43}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9b8b6e4b-7718-42aa-8e29-ea0ef4b82160	lotto6	987	2015-07-23	{3,14,15,24,25,36}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
048a10ec-dffd-46fb-b05d-16f579e72e08	lotto6	988	2015-07-27	{5,6,10,22,34,41}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
8ef9f4eb-a9c1-4f57-b8a0-a543cc039286	lotto6	989	2015-07-30	{5,7,31,33,36,39}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f69a95fb-4195-461f-9dee-50c58a41e963	lotto6	990	2015-08-03	{4,12,16,27,28,41}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
973ad6ca-215a-4a94-9007-31e947f7ea21	lotto6	991	2015-08-06	{3,18,21,25,29,37}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
fe2d07d5-2013-45e4-a37c-da211806d8d1	lotto6	992	2015-08-10	{4,6,8,22,27,38}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
559cc4c4-a564-4f02-ac6f-d1e331031980	lotto6	993	2015-08-13	{1,5,10,32,38,40}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
41dc12af-8abb-4bde-ac40-c0da19352b78	lotto6	994	2015-08-17	{18,22,29,31,39,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f39cb141-3756-4106-9fc9-c9731e7172d0	lotto6	995	2015-08-20	{7,11,17,21,37,39}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
897f7259-beec-4b11-9e32-fc1834993958	lotto6	996	2015-08-24	{1,3,14,26,27,42}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
7d312dae-9834-4ea3-955a-9e37fa24c6fb	lotto6	997	2015-08-27	{3,5,8,11,33,43}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9094c79e-3cbc-4474-a3c7-b6e78b51bd4a	lotto6	998	2015-08-31	{1,3,12,19,26,29}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
f6a0092f-54dc-4550-a619-d787ca96bb1a	lotto6	999	2015-09-03	{8,15,17,30,32,36}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
d0bdd45d-75b8-4ac9-8474-31661ef031fe	lotto6	1000	2015-09-07	{1,15,21,22,26,29}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.514666+00
9ad34b4c-da0b-4419-86a9-b003df7cc517	lotto6	1007	2015-10-01	{3,8,17,25,28,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8803af1e-89df-4ab5-a588-c6279f956c5e	lotto6	1008	2015-10-05	{11,14,16,21,24,39}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
39f50001-ae76-411c-9860-31e2751d37e6	lotto6	1009	2015-10-08	{3,19,34,36,40,43}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
906fabb5-ac67-46e3-9565-9de00b8d2703	lotto6	1010	2015-10-12	{6,12,16,24,25,37}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1443fd90-3270-4965-8440-467831950623	lotto6	1011	2015-10-15	{23,26,27,29,30,43}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a81dd73a-db78-4679-847d-5e4b0f6fe716	lotto6	1012	2015-10-19	{9,11,19,22,27,38}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
472e250e-bdeb-45a8-8020-5169afc88b02	lotto6	1013	2015-10-22	{3,20,36,38,39,41}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d691e8fc-a4b6-4e84-ba21-706f2d5795bc	lotto6	1014	2015-10-26	{2,3,9,19,40,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5cbadeab-569c-4e8c-ad35-6b2cf803f7ab	lotto6	1015	2015-10-29	{9,14,20,23,27,32}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4141e8c7-de0d-40d1-b750-5a5084d3919c	lotto6	1016	2015-11-02	{1,14,31,32,39,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f6c4d8e9-4aff-4969-b592-aaf62cbb7cb5	lotto6	1017	2015-11-05	{1,4,24,30,39,40}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bedd25d3-50ea-4920-8b87-9bf6119a1896	lotto6	1018	2015-11-09	{3,22,25,28,32,39}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
253063b6-dc54-4e74-b782-c25d7bd395d3	lotto6	1019	2015-11-12	{8,14,15,22,25,40}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9f1d53f2-65e7-406b-94aa-375294d80a6e	lotto6	1020	2015-11-16	{2,25,27,28,35,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
409309f7-07f8-453d-a974-81f96b683d0b	lotto6	1021	2015-11-19	{3,30,32,33,34,39}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d28b9274-d49e-4f69-b388-2c1cc5580a32	lotto6	1022	2015-11-23	{3,15,19,30,34,37}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
979893dc-e45e-49f4-8192-4f90e993e7b5	lotto6	1023	2015-11-26	{9,17,24,25,33,40}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c4637049-17c7-43b1-82aa-fdf901fa5c8d	lotto6	1024	2015-11-30	{2,4,5,20,37,43}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b8ad9f61-488d-4414-b06b-0a28f8ec2788	lotto6	1025	2015-12-03	{10,17,20,21,36,43}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
116ef700-b524-4281-811f-02145e9e18e3	lotto6	1026	2015-12-07	{1,8,11,17,22,26}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7994b9c4-4211-4659-9c99-776916ef1f34	lotto6	1027	2015-12-10	{13,16,17,19,20,38}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
82f3215e-3c5f-4ce9-938b-8fff2ea9322a	lotto6	1028	2015-12-14	{7,10,18,21,28,36}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
862a31d5-2ad5-4f67-b3cf-ab5f6b0b72bd	lotto6	1029	2015-12-17	{5,13,22,31,37,39}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c3d2f7c5-a6c0-443e-a758-f8ec11718b39	lotto6	1030	2015-12-21	{4,9,17,20,23,42}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
19a0e947-0bf9-46e8-8392-370e972e96d7	lotto6	1031	2015-12-24	{2,4,7,22,32,35}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
23e9bfc5-22e3-43fe-9102-576ddf6e6021	lotto6	1032	2015-12-28	{11,20,21,30,36,43}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1423d548-3765-4440-b88d-9908f1c98d49	lotto6	1033	2016-01-04	{1,15,21,24,37,41}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9d2e812e-15f4-4ba3-9a83-767a1cb16550	lotto6	1034	2016-01-07	{14,20,24,25,31,32}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
50477251-0acc-4867-a924-e0d6cf2140a1	lotto6	1035	2016-01-11	{9,15,17,19,27,33}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9d45b162-4fdd-4140-9573-8c7cf71cc6e9	lotto6	1036	2016-01-14	{2,8,17,27,30,31}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5edce077-c5bd-4ed5-ae4c-133c846400c6	lotto6	1037	2016-01-18	{1,3,12,13,21,32}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ae456b75-13ac-46b1-b3f3-bd7784fc091b	lotto6	1038	2016-01-21	{3,7,24,25,27,39}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a9d404bc-afe6-4d0f-9efe-dbb0a7b4f57b	lotto6	1039	2016-01-25	{6,9,20,34,37,41}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
60d408c3-1e8e-4f1d-912a-4652062c393a	lotto6	1040	2016-01-28	{7,13,15,21,23,34}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b050dbec-6089-44c9-bb6f-e916a461781c	lotto6	1041	2016-02-01	{14,22,27,29,33,37}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f9ace66c-2c9b-481b-9d3b-e7a383f5eea2	lotto6	1042	2016-02-04	{4,10,11,12,18,25}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a3f11ef2-5409-46ec-89aa-829c26d14c7a	lotto6	1043	2016-02-08	{21,29,30,32,38,42}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ae0bd724-132f-4ba8-948a-ca2c099119f9	lotto6	1044	2016-02-11	{3,7,16,26,34,39}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
12a100fd-bfb3-4fe4-89a0-6e4629b97217	lotto6	1045	2016-02-15	{1,19,21,30,31,43}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
23de6c37-cd2a-4372-b1df-75891f48990b	lotto6	1046	2016-02-18	{6,13,17,18,27,43}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8b55c98f-1a58-4950-adf0-fc272fed5b3f	lotto6	1047	2016-02-22	{5,9,13,31,32,35}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e22f31fb-34df-41a3-a414-6814e2cc97b9	lotto6	1048	2016-02-25	{26,27,30,31,34,40}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
308c8a7b-d5da-4add-9219-eb9b15520be5	lotto6	1049	2016-02-29	{3,6,15,23,24,31}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f6149103-f4c8-419e-b048-05889eee3f59	lotto6	1050	2016-03-03	{3,8,14,28,31,43}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1afa9218-97dc-4c99-9642-06bc6b4bee6d	lotto6	1051	2016-03-07	{5,13,20,28,30,32}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
43b5ee86-a3fa-4ddf-a902-a5a4b15a6dae	lotto6	1052	2016-03-10	{6,26,34,37,42,43}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
acd5c381-9298-4652-802f-3a8bcc92f2f3	lotto6	1053	2016-03-14	{4,11,23,27,35,42}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c6fad19f-9d26-4e4d-8697-dc30029786a8	lotto6	1054	2016-03-17	{7,9,10,19,28,33}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
768c5441-d58c-4eef-9233-d4471e735ecc	lotto6	1055	2016-03-21	{5,11,20,25,26,32}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a38a7f93-60af-4d13-be7f-95191f6a62d4	lotto6	1056	2016-03-24	{14,16,19,29,32,37}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c600846c-954e-4dfd-9c1e-f905944c9739	lotto6	1057	2016-03-28	{2,11,19,21,28,38}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a27a5e20-8afc-4922-8c0b-c6ed002ec25b	lotto6	1058	2016-03-31	{11,12,17,23,29,43}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
92de0fbd-6f4a-41c5-839f-8fd34fbdadab	lotto6	1059	2016-04-04	{8,26,27,29,35,43}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4afbf5ac-75ef-4f86-adf3-d2a1b149d29c	lotto6	1060	2016-04-07	{5,10,16,17,32,37}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7524e67f-76c6-42fa-acef-fb3be084e881	lotto6	1061	2016-04-11	{1,12,14,16,20,29}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5a7f17bb-2fd0-4e15-83e6-ff24f520fdde	lotto6	1062	2016-04-14	{2,7,28,39,42,43}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6eb83c65-2aa5-462e-b7f8-f3da9d5e8055	lotto6	1063	2016-04-18	{6,12,13,34,38,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
82d30524-95a9-4cae-937c-4aa1ee236a02	lotto6	1064	2016-04-21	{4,13,18,27,30,39}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
32cd21ea-9075-4da6-b9b5-c2db6a171669	lotto6	1065	2016-04-25	{11,13,27,37,41,42}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bd396380-448c-49c4-82e3-d61c812a2dda	lotto6	1066	2016-04-28	{2,11,29,36,40,42}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
44f14781-637f-46b1-8477-728172db1b3f	lotto6	1067	2016-05-02	{5,9,25,27,28,33}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a095aa5e-6726-4fdd-95a5-391a060e88c9	lotto6	1068	2016-05-05	{3,9,21,34,35,42}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
74aecea7-f9b1-41ad-a899-7aeeee9380f0	lotto6	1069	2016-05-09	{12,17,26,30,33,40}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
be020fc6-549e-467e-b70b-1b502ff47716	lotto6	1070	2016-05-12	{11,21,25,34,35,36}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
72f60b4f-abfe-4b41-a4b2-a2a30b63700d	lotto6	1071	2016-05-16	{1,10,25,27,31,40}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
90c6e474-722e-4f24-9e83-dd6ef26f00b6	lotto6	1072	2016-05-19	{3,17,20,32,36,43}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
29eae721-f17a-42ef-8a6b-6d6add069321	lotto6	1073	2016-05-23	{1,3,5,8,20,39}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f3647bed-324b-4593-b904-014e5d629cba	lotto6	1074	2016-05-26	{8,9,16,27,30,33}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cc0ef24c-10b5-4bd4-8386-b261952f05d5	lotto6	1075	2016-05-30	{7,8,21,24,34,42}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d0aa778f-6043-4f58-80a1-b6445b7917bd	lotto6	1076	2016-06-02	{21,22,24,30,31,43}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7ee7b27e-852e-4d8d-a1af-81953d77ef03	lotto6	1077	2016-06-06	{1,4,9,23,30,36}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e02f8ef3-380e-42b1-ba79-b4990c7495d7	lotto6	1078	2016-06-09	{3,12,20,33,35,41}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
53c6b01c-7a8e-4ad0-81ae-1cdea482ff80	lotto6	1079	2016-06-13	{8,12,19,24,30,36}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bf248a22-037f-4e48-a17d-16887979bfa9	lotto6	1080	2016-06-16	{6,15,16,19,38,41}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0fb88270-21da-4828-bc9a-7581f65cebc3	lotto6	1081	2016-06-20	{6,8,13,17,18,20}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b863e0ea-b46d-4ab3-bfc6-09c36fc8d628	lotto6	1082	2016-06-23	{9,12,19,21,39,40}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
16dc7785-2790-47ba-abd5-69b3a65bfae6	lotto6	1083	2016-06-27	{10,13,15,18,25,38}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0e952283-a2d7-486b-9354-b6bba9735116	lotto6	1084	2016-06-30	{1,7,20,28,34,38}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7311777a-4b2d-4a49-8ac4-e7a1b7a1f856	lotto6	1085	2016-07-04	{3,20,21,30,34,35}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
15cbd674-993e-4a53-a79a-ff96b1c55ce8	lotto6	1086	2016-07-07	{3,7,9,31,38,43}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5a538d06-7088-4b49-ab5b-cb15f8037bb7	lotto6	1087	2016-07-11	{10,13,26,27,30,36}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7e914af8-7953-4cda-86d8-28ca8bcf8905	lotto6	1088	2016-07-14	{5,8,16,24,32,33}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
06513bd7-51ad-433c-b4b5-614cfa22aacd	lotto6	1089	2016-07-18	{5,17,19,22,41,42}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cc982672-e149-4351-9d6c-75921f59879c	lotto6	1090	2016-07-21	{3,10,15,22,27,40}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a0296788-afa6-4f6f-aa26-f8dd8c587a65	lotto6	1091	2016-07-25	{21,22,24,26,28,30}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a53c37da-857e-41b6-8c6b-13ede19f0208	lotto6	1092	2016-07-28	{2,11,18,27,30,33}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
73290a44-7f36-4525-a56b-7ad859cd02c9	lotto6	1093	2016-08-01	{4,19,26,40,42,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
72534fcf-8982-4cf3-a4e1-e3a3b54bd658	lotto6	1094	2016-08-04	{6,7,20,24,28,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2f5d17f5-8504-4b04-9d52-d7c58850cf21	lotto6	1095	2016-08-08	{3,6,15,18,23,27}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4befc067-649a-46c1-8fa6-2934c0faf6c4	lotto6	1096	2016-08-11	{6,19,21,31,38,41}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8d78b1c2-8335-4899-90c8-a58c97fc68ff	lotto6	1097	2016-08-15	{1,5,8,14,19,21}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
209b5895-c375-4a68-ad7e-53ba5a9ab6da	lotto6	1098	2016-08-18	{1,19,31,33,35,43}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
01380950-bdad-4326-8f13-cccccedb597b	lotto6	1099	2016-08-22	{6,8,12,17,18,24}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
45aa1e09-008c-4294-97d5-e5c476366846	lotto6	1100	2016-08-25	{2,6,16,23,32,35}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e3e99df7-979a-4149-80dc-0804d0384c72	lotto6	1101	2016-08-29	{4,5,7,10,13,16}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
42d30a0e-887d-4e55-a7a3-647160936832	lotto6	1102	2016-09-01	{3,6,9,13,36,37}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
04f7f712-9abf-4bf4-a8cb-ea9388c47f8b	lotto6	1103	2016-09-05	{8,13,14,18,24,38}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
99b698f5-a828-4a11-a829-8208560be62f	lotto6	1104	2016-09-08	{15,25,32,33,36,38}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
23937466-fc2b-48a1-9c60-2c6bcc96c32a	lotto6	1105	2016-09-12	{12,15,25,31,39,40}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7b13b1ed-7378-4c3a-8336-cc83f3a162cb	lotto6	1106	2016-09-15	{1,4,8,10,18,33}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
db47eaf6-84bd-45be-839d-da9e0dcc39b7	lotto6	1107	2016-09-19	{6,7,12,22,30,33}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5179c8f3-542a-4875-822e-94674ec4393b	lotto6	1108	2016-09-22	{12,25,29,32,38,43}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3f045a5e-becf-4cf0-9133-53b05833feab	lotto6	1109	2016-09-26	{6,8,14,27,36,42}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e1d0b3d9-32ed-4ca6-8537-003bfa37e97c	lotto6	1110	2016-09-29	{1,6,21,34,36,39}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0fe4f557-6cd6-4a5d-a353-c57344ac6b5c	lotto6	1111	2016-10-03	{6,16,17,27,33,41}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2c09567c-3dce-4bf0-8af8-52dd0f45b517	lotto6	1112	2016-10-06	{6,9,15,19,39,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9140bcc7-77c1-4eb6-bf72-b64f375d3a0d	lotto6	1113	2016-10-10	{1,12,14,26,34,41}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5648bf98-0d4e-414d-9639-2c2968edb8eb	lotto6	1114	2016-10-13	{2,7,9,28,38,39}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b83b3426-e950-4603-89a9-b843c0f514b5	lotto6	1115	2016-10-17	{3,10,12,26,38,42}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8fb765d4-a173-4d91-8fc0-9f0ab66f106e	lotto6	1116	2016-10-20	{1,11,33,34,35,38}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
987ff85a-8d59-47c9-970c-cf7576b4840f	lotto6	1117	2016-10-24	{2,6,7,9,19,23}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1b637d4d-b7f2-44be-b83e-183a9a369e2d	lotto6	1118	2016-10-27	{1,11,21,25,34,36}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4bdb267d-65d7-4c5b-99f8-b6c90880bdba	lotto6	1119	2016-10-31	{3,6,15,21,42,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4e25daa8-5436-404a-8083-2ceb63bcb5c9	lotto6	1120	2016-11-03	{10,12,13,29,35,39}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7df6d217-249b-40e6-b873-d5dd86107ac7	lotto6	1121	2016-11-07	{2,8,31,38,40,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bc11a30e-2cac-42c3-a4ba-33098fbccad8	lotto6	1122	2016-11-10	{22,24,29,31,32,34}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
55f3bd0a-4ded-4d1a-9b64-8b16f20fa2b1	lotto6	1123	2016-11-14	{4,8,23,29,34,35}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bf42436b-6b25-40a0-8dd9-e5c7ea3a6db2	lotto6	1124	2016-11-17	{1,16,24,28,40,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
440ebf90-23bc-40d3-a3bf-118fe8a11952	lotto6	1125	2016-11-21	{2,16,19,20,24,36}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bdff0d80-85b7-47e4-b0de-b5404fe7a2fb	lotto6	1126	2016-11-24	{4,5,26,30,34,42}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bbde5f64-018c-4344-a0d2-ba7711e99c13	lotto6	1127	2016-11-28	{9,15,17,21,23,42}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f7e9c558-4340-4f7c-b86e-fec8d66ea14d	lotto6	1128	2016-12-01	{3,15,21,29,30,35}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c7ba6af3-6709-4d90-a35a-d2ac3ff10dab	lotto6	1129	2016-12-05	{6,11,19,28,30,43}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c3b8b95f-2154-4315-9abd-1de4add77aeb	lotto6	1130	2016-12-08	{1,11,37,38,39,42}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
671ed14b-a2b7-4e06-939a-2fe3d1d1809c	lotto6	1131	2016-12-12	{6,12,25,36,38,41}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
af1eb4d2-53bb-4d83-a70a-187ba821a9be	lotto6	1132	2016-12-15	{4,5,24,29,33,35}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8cde61cc-72a5-49e6-b86b-5db594cc2e2f	lotto6	1133	2016-12-19	{3,18,19,20,37,38}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cac96363-3617-4b69-84ce-6d42cbe5062f	lotto6	1134	2016-12-22	{5,6,12,14,30,38}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ad7f51ef-ac7c-4bc1-bd5e-124527f86f53	lotto6	1135	2016-12-26	{20,22,28,29,32,41}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
78bad565-cf6d-47c2-b0c3-15d2c8d6a0e9	lotto6	1136	2016-12-29	{3,4,7,8,22,33}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2ac950cc-102f-419c-848e-8fba75ac0ddd	lotto6	1137	2017-01-05	{1,18,21,31,37,41}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ec6e8506-d8de-4d0b-aea5-dd875fe270d9	lotto6	1138	2017-01-09	{8,15,21,24,35,38}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d76062ef-736a-4fe2-b07d-7c75b11f2785	lotto6	1139	2017-01-12	{4,6,14,17,23,33}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0ddbfc9d-b0ad-4b34-bf0b-b1da7b8be7e2	lotto6	1140	2017-01-16	{11,21,30,31,36,37}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e1f1affc-6dfe-43e0-a303-8534f0fa283f	lotto6	1141	2017-01-19	{1,4,10,14,24,26}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
238a91f0-331c-4662-8d2d-b7d400e97272	lotto6	1142	2017-01-23	{12,13,19,23,28,35}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4eaf7ae7-1a1f-4a07-b761-2b3269f62033	lotto6	1143	2017-01-26	{19,21,31,39,42,43}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
33c99543-9c34-4240-9fff-69a685bce23e	lotto6	1144	2017-01-30	{7,13,14,33,39,43}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cd47c5e9-f02f-46dc-a076-f76876e567ec	lotto6	1145	2017-02-02	{1,4,15,18,25,28}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
af9f33af-ad3d-4887-8fca-6fb723485b0b	lotto6	1146	2017-02-06	{1,10,19,23,26,34}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
36f6ad4c-9450-4ef9-b8ee-50ea63828b88	lotto6	1147	2017-02-09	{2,3,10,16,26,27}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fad49ed4-ad6f-4d73-90ec-bfa61c5377ae	lotto6	1148	2017-02-13	{3,5,16,23,31,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1a249d5e-4013-4491-b00a-558e3ccbbb39	lotto6	1149	2017-02-16	{2,14,22,23,35,43}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2cdccd5c-dadb-4b8c-ba8b-bb6c7062d62a	lotto6	1150	2017-02-20	{7,11,17,27,32,40}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1065685c-9488-4e24-8fb5-9cc7ef49e3e3	lotto6	1151	2017-02-23	{5,23,25,26,29,31}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dbdc8811-0afc-46d8-801b-6cb8f1fac35d	lotto6	1152	2017-02-27	{6,8,10,33,35,43}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c08596b6-3adb-413a-bd5e-afc1306aa0d1	lotto6	1153	2017-03-02	{4,15,20,24,26,30}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
20ca3793-dd51-47a3-9f92-7f2accc010e0	lotto6	1154	2017-03-06	{8,12,30,36,41,42}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
78f217fe-9df7-4e94-adfc-938056346311	lotto6	1155	2017-03-09	{14,19,22,23,28,43}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dd3f4add-4b5a-448b-9a4f-839e3c9301b6	lotto6	1156	2017-03-13	{3,6,19,31,35,40}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
403088b9-8eb7-4dc0-a8c6-1f065f93abdf	lotto6	1157	2017-03-16	{5,17,20,28,39,42}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2414805b-b509-4f1e-8d40-daede00385eb	lotto6	1158	2017-03-20	{22,24,27,30,32,40}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f5e02f1d-3225-465b-9de8-f794a6c89eae	lotto6	1159	2017-03-23	{1,4,15,16,23,30}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fd41ec19-8711-4e0d-90b0-bc4a24aed2ac	lotto6	1160	2017-03-27	{9,22,31,32,34,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9293d724-315d-4ceb-8320-45e6ad2e6b87	lotto6	1161	2017-03-30	{1,2,12,16,19,40}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2e058bb2-7c4f-42a8-9ee9-775d8bfe7271	lotto6	1162	2017-04-03	{3,4,8,12,24,37}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3ce8bf4e-54fa-414f-a226-ba857bc9e881	lotto6	1163	2017-04-06	{11,17,19,24,33,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5ca0ceed-8f28-4904-b396-d18b968683e3	lotto6	1164	2017-04-10	{4,7,11,33,34,37}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4d9eb51b-686a-4638-9d0f-b091effd8456	lotto6	1165	2017-04-13	{18,20,21,24,40,42}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
54bdd200-1ccc-4102-a7a4-5bf0d4717f80	lotto6	1166	2017-04-17	{4,8,17,20,29,41}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
63b88cf7-dafd-40f3-b02e-9db17a083f2c	lotto6	1167	2017-04-20	{6,13,20,25,36,42}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9126e415-283e-41fb-ba0b-63a3613a2f1d	lotto6	1168	2017-04-24	{1,3,8,14,35,39}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bd4ae8bb-4383-441f-af4d-7b5aed67325e	lotto6	1169	2017-04-27	{19,24,25,36,37,43}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f395e6e0-8f99-4e9a-a6e2-397cee8ff4d1	lotto6	1170	2017-05-01	{1,8,13,19,23,28}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b7038c21-9455-49df-b510-0e85ef0b8401	lotto6	1171	2017-05-04	{9,10,13,21,34,36}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
10b1f8c0-72d5-44e6-a911-8eb1b4a8a9a0	lotto6	1172	2017-05-08	{3,10,31,32,38,39}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5025e574-6fe4-4eb4-af45-5d721bfd2c64	lotto6	1173	2017-05-11	{5,7,11,16,33,38}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e416ca08-3254-4ba4-b864-fc1829bac79f	lotto6	1174	2017-05-15	{7,8,9,25,29,31}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9630b8d1-3902-4e84-b98f-12938d9ca765	lotto6	1175	2017-05-18	{2,4,6,21,27,37}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2afa953d-763c-4ac8-b00c-5071e28885ef	lotto6	1176	2017-05-22	{2,9,18,23,29,32}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6634b572-825b-42d6-bc47-ea75597d03f2	lotto6	1177	2017-05-25	{2,5,21,22,23,38}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4b9ef6f1-ffb5-4053-a1ce-d3c32db4f702	lotto6	1178	2017-05-29	{16,17,20,22,29,40}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3e3aed14-c074-4c1c-bfec-872ec43d0d59	lotto6	1179	2017-06-01	{5,12,27,36,39,40}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d9fe115c-9d05-4c98-a8bd-2ed5baa51658	lotto6	1180	2017-06-05	{2,4,5,13,18,21}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f796ca26-f5e9-4a00-92c1-cc83a4239c8f	lotto6	1181	2017-06-08	{15,16,17,29,31,32}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
16b71c24-4e54-448b-88e2-3d7098fd76be	lotto6	1182	2017-06-12	{5,6,10,13,24,33}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d5055305-d194-49d7-b322-4b33f9814eb8	lotto6	1183	2017-06-15	{2,19,22,25,32,36}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
12e6059c-5091-41c2-a8a8-5bcc82f164c1	lotto6	1184	2017-06-19	{2,6,21,30,31,36}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3a0a509a-c97a-432c-b429-6b8aab6017f6	lotto6	1185	2017-06-22	{6,15,18,26,27,31}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c91511eb-f28e-4c64-bc3a-52aa17246b94	lotto6	1186	2017-06-26	{8,10,20,25,38,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d72617f7-94f0-4de9-986f-8b90c8921f50	lotto6	1187	2017-06-29	{3,13,18,20,24,31}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f7e27c5b-8484-4a04-a1a9-1a499fc4181a	lotto6	1188	2017-07-03	{3,9,19,20,23,30}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
08173604-dfaa-4a09-9ccf-4396bd224dc9	lotto6	1189	2017-07-06	{8,24,28,30,38,41}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4567358d-247a-4e67-9fe5-ccb5bba63072	lotto6	1190	2017-07-10	{1,3,13,29,38,39}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
92e14daa-6521-432a-9a28-36bd87e99cb2	lotto6	1191	2017-07-13	{3,5,11,20,25,32}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b758f3f1-ea5e-4975-b2ec-658e42a0ad43	lotto6	1192	2017-07-17	{15,17,18,22,30,39}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3747d7d3-a17b-4ec8-a650-bc0eab85265c	lotto6	1193	2017-07-20	{1,2,7,8,10,42}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
abd7726d-5144-4435-b093-6a60baeb870c	lotto6	1194	2017-07-24	{12,18,20,23,33,40}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
45015e7a-f4c0-4e0b-8af5-5545b1eab057	lotto6	1195	2017-07-27	{1,4,17,22,35,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3f6eadcb-7972-4187-aa4e-dcc41f77d3ab	lotto6	1196	2017-07-31	{6,7,19,31,39,41}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a641a5ab-4965-4f18-af66-cb42082eafaa	lotto6	1197	2017-08-03	{3,24,28,36,37,39}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
407168fb-e09e-4503-b33b-101b30ae850a	lotto6	1198	2017-08-07	{1,14,20,26,27,34}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3e07d1ef-9d44-46cc-82ac-773ac67a9bc6	lotto6	1199	2017-08-10	{9,10,11,20,28,40}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a78a5776-831a-4a5b-95f5-52bfc0b513dd	lotto6	1200	2017-08-14	{2,8,10,12,31,42}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
283a929a-4148-420c-9a64-b6c77af0e954	lotto6	1201	2017-08-17	{1,15,19,22,26,28}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a43037e0-d246-4f5a-8bbe-1438388dbe08	lotto6	1202	2017-08-21	{9,12,15,19,26,39}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c8e187ae-af17-4d87-802e-1d3f49f25d43	lotto6	1203	2017-08-24	{2,4,6,37,39,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7870786a-b79d-4648-9c46-50406751bd55	lotto6	1204	2017-08-28	{10,20,21,24,39,43}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a244765b-d768-4c35-be78-f4ddb8f74a05	lotto6	1205	2017-08-31	{12,25,26,32,35,42}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
85e553b1-cd4e-42f9-8d4c-b0e449757174	lotto6	1206	2017-09-04	{11,19,20,26,32,33}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
87a36685-d3e9-4ec5-9635-3f72fe206571	lotto6	1207	2017-09-07	{6,16,17,20,22,43}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d927f4b7-8e3c-404a-b4bd-5643b9e703aa	lotto6	1208	2017-09-11	{5,14,20,30,38,41}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a0c7512a-1116-4658-bfd0-fd3686a619bf	lotto6	1209	2017-09-14	{11,12,24,32,38,40}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dc33e277-4404-4645-bcc1-24f47c33d6b8	lotto6	1210	2017-09-18	{5,6,12,16,23,36}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dfb1bfe7-b704-4d2e-bf38-98b6436c123c	lotto6	1211	2017-09-21	{3,8,24,25,26,28}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
57e7a96d-5186-4904-a488-6d0141e6165b	lotto6	1212	2017-09-25	{2,16,27,35,40,42}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
33544d88-a149-40e3-a5ff-f1e526bacd62	lotto6	1213	2017-09-28	{3,13,22,26,30,39}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2e3c4df8-c23c-478c-afad-5e464f0c624d	lotto6	1214	2017-10-02	{2,19,23,30,33,36}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8af127cc-1b1c-4e94-a279-784ae34afc67	lotto6	1215	2017-10-05	{3,6,9,15,21,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0ad69930-00e6-48a0-91fc-79d34a5212d2	lotto6	1216	2017-10-09	{8,14,25,39,42,43}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9738581b-ee64-4164-8818-5d38952a1f73	lotto6	1217	2017-10-12	{14,16,17,34,36,41}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9c16a40c-218e-4f17-8212-9f37eb8f00c0	lotto6	1218	2017-10-16	{5,8,13,20,28,42}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1efd1191-a99b-4744-a5c9-906720551429	lotto6	1219	2017-10-19	{14,22,24,36,39,42}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d03866cc-1052-4b94-a9c9-a0c104dd6b2e	lotto6	1220	2017-10-23	{9,15,21,23,32,42}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bf7df98c-b653-4056-b37c-f3ae6a42924a	lotto6	1221	2017-10-26	{3,10,11,31,33,36}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9376a3e1-ebca-4f83-8ecb-01fce79f52d6	lotto6	1222	2017-10-30	{1,5,7,11,29,39}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
45e3fbeb-afa5-4ae9-853b-cb68a3266035	lotto6	1223	2017-11-02	{12,22,28,30,36,43}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7ca1ffef-2692-4290-b215-947cc635791b	lotto6	1224	2017-11-06	{5,18,33,38,41,43}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a9a1de12-df61-4305-8f68-5b42420ad84e	lotto6	1225	2017-11-09	{19,22,25,30,33,34}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
035d8985-3c4e-4307-aba6-0423eacb2777	lotto6	1226	2017-11-13	{7,8,28,34,37,41}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
04199fac-e4a8-4f9d-9cb2-72fc7a731d4e	lotto6	1227	2017-11-16	{1,8,14,28,40,43}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
721d10ff-0688-4895-b88f-22d8e5c277ea	lotto6	1228	2017-11-20	{6,18,19,25,28,40}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
652b3065-dd9b-4cc7-b48d-1c809521fc14	lotto6	1229	2017-11-23	{10,28,35,37,39,43}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ae4db8e2-364e-4fca-bfc5-674a2946a1e2	lotto6	1230	2017-11-27	{1,2,6,9,17,38}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
47c43b6a-2931-42f6-acbf-03016c39a745	lotto6	1231	2017-11-30	{1,14,16,24,32,36}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
71a6b913-d74b-4876-8223-d22bfe2bad53	lotto6	1232	2017-12-04	{5,10,14,31,35,38}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6bbc49f1-665f-4ecc-9dfc-bccf2a632bb4	lotto6	1233	2017-12-07	{2,7,12,21,29,33}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1789ad47-122b-4996-b844-bb4b5bd0547f	lotto6	1234	2017-12-11	{7,11,16,20,30,40}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
42dd12eb-8a7d-44c7-8a29-32880185d4c5	lotto6	1235	2017-12-14	{8,17,24,34,36,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9123e023-e14f-4b07-9fbf-54b911b565c8	lotto6	1236	2017-12-18	{1,3,11,26,38,39}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3989c6f8-bd00-4f08-9a51-6f468b4a30cf	lotto6	1237	2017-12-21	{1,4,6,35,38,40}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fd55243c-1685-4a56-bc3a-de88c7c99882	lotto6	1238	2017-12-25	{8,14,28,29,33,40}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7356b3dd-6f93-4299-87f4-2ec87555d852	lotto6	1239	2017-12-28	{2,19,27,28,30,38}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5364bdcc-ff67-471b-ba37-e13760dc107d	lotto6	1240	2018-01-04	{15,18,22,36,37,39}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cb80ef52-fca3-4961-8df2-1f6ba64d46c4	lotto6	1241	2018-01-08	{4,7,15,17,23,25}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
82b3ae17-7c87-48cd-8995-3fbb3dfd7e52	lotto6	1242	2018-01-11	{12,22,28,34,37,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
75fc4b2e-1f72-4012-8704-18948ac95f66	lotto6	1243	2018-01-15	{23,24,32,37,41,42}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f90b0804-bdb1-43e2-b080-86eeaf7f56bc	lotto6	1244	2018-01-18	{10,15,17,18,20,41}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a5110631-2a66-42bb-b5b1-a3548236654c	lotto6	1245	2018-01-22	{13,15,27,30,31,39}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
24c2052f-0edd-422c-a6ee-0875b3db3565	lotto6	1246	2018-01-25	{4,10,11,23,36,37}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f22ced07-a2d9-4cde-a71b-8733c187ad09	lotto6	1247	2018-01-29	{4,7,17,18,26,36}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9938a120-c939-4410-86ef-4cd7313928fe	lotto6	1248	2018-02-01	{2,6,14,28,34,37}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
91b2e75a-867e-4b54-bf4e-940bb085a5ea	lotto6	1249	2018-02-05	{5,8,15,20,25,27}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b041b533-bda2-4ea7-8787-386a4f14db91	lotto6	1250	2018-02-08	{3,10,18,22,23,40}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
66943ade-e376-4271-a80e-78e968a1b70d	lotto6	1251	2018-02-12	{21,28,31,33,34,40}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
532ab707-fc14-46c9-877d-aea80e5f1127	lotto6	1252	2018-02-15	{4,15,18,19,22,29}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1d725edc-e97e-446a-b5ba-799dd79ab7b8	lotto6	1253	2018-02-19	{1,12,14,24,33,37}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
139e2502-a2a4-4c3e-bb47-9bbf65575de2	lotto6	1254	2018-02-22	{7,8,11,15,36,39}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4a4d0d7f-02df-48c3-87a9-64eba354856d	lotto6	1255	2018-02-26	{2,14,15,27,40,43}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
686ccc1a-d4b3-40d0-a63a-695742bbb5f2	lotto6	1256	2018-03-01	{2,5,16,32,35,41}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cb41731b-95ca-4a9d-b47f-3d9d0926b803	lotto6	1257	2018-03-05	{1,11,19,23,32,37}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
446a87ea-7d4a-436e-a608-5c5927e891d2	lotto6	1258	2018-03-08	{8,14,20,25,31,41}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3ebd5ddf-4dc4-4e52-9ec5-06811039176b	lotto6	1259	2018-03-12	{10,16,20,26,33,36}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
36b13a57-0617-46a7-ad74-b5989f86baa1	lotto6	1260	2018-03-15	{3,8,16,19,25,26}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
02d3cc43-37ba-4c5f-902b-af87c46d84a0	lotto6	1261	2018-03-19	{9,20,26,29,30,34}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cfc7596e-b8e6-40a3-8b50-35cee2b65bf8	lotto6	1262	2018-03-22	{4,11,15,20,24,43}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0ba160bb-ccae-4b8d-88bd-b0bed5c2ac31	lotto6	1263	2018-03-26	{3,8,13,14,31,37}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1eef8ab0-3d5b-44a0-b15d-2e6ccf5f8618	lotto6	1264	2018-03-29	{1,6,27,33,35,43}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5b6ee3fa-24f0-4d2c-a056-7031466f957c	lotto6	1265	2018-04-02	{5,20,26,27,28,33}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
84fefc30-1c69-4dab-a286-b83cad5469fc	lotto6	1266	2018-04-05	{3,12,16,23,25,28}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
668db8d4-5145-43e9-8428-6d92c5d0d98b	lotto6	1267	2018-04-09	{4,18,31,33,34,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d360e1dc-4225-42b7-8466-953a9bfa492a	lotto6	1268	2018-04-12	{8,11,15,22,35,36}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
eeaf8bcc-dc3b-4e77-9cb3-dc18b46a4fa9	lotto6	1269	2018-04-16	{9,10,11,33,39,42}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6cc3a0f8-aeb9-49fd-bcac-c1383e5f910d	lotto6	1270	2018-04-19	{9,10,24,30,35,40}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b3caf197-780f-4bf4-8df7-a4f088afcc09	lotto6	1271	2018-04-23	{1,11,14,27,39,42}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6899684d-1944-494f-9be5-f40daf2b16eb	lotto6	1272	2018-04-26	{4,9,13,32,37,38}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dcbaa046-3398-4c94-9f61-b85ef136bec5	lotto6	1273	2018-04-30	{18,20,22,26,34,37}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dfca6e76-85f2-4617-98cd-2990983f7ea7	lotto6	1274	2018-05-03	{3,15,18,23,31,37}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e9593248-5bc5-46d1-9aec-f704e2713f16	lotto6	1275	2018-05-07	{7,19,21,28,40,41}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d484d784-f9e3-4ffb-8282-9025b4deb1a2	lotto6	1276	2018-05-10	{5,6,9,11,16,35}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c3188522-50f3-4ad5-8388-8a21abdf7cdf	lotto6	1277	2018-05-14	{12,16,20,22,31,43}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e7fd3bda-9a17-4160-be8d-f53f63c7dc65	lotto6	1278	2018-05-17	{3,4,18,28,34,36}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4d3bbf76-81b9-4980-a015-a135a21737c2	lotto6	1279	2018-05-21	{4,10,16,17,20,24}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2afeb9bc-d400-49fe-9b0f-80c8d6de4e84	lotto6	1280	2018-05-24	{1,9,11,21,29,36}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
26fc1f93-d383-4aa3-b367-89fc7af115a8	lotto6	1281	2018-05-28	{3,7,9,15,29,40}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a45cf376-3c04-4878-96d3-3d73a607a875	lotto6	1282	2018-05-31	{1,4,10,11,24,28}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
566c35bd-c705-47d6-94c0-a5c17cdb3e12	lotto6	1283	2018-06-04	{1,26,27,30,37,38}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4875c215-60d8-49b2-8e6a-6e9bf1ee6aaf	lotto6	1284	2018-06-07	{4,14,17,21,24,39}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8da2505e-d8ce-4292-a096-a5182cfa534f	lotto6	1285	2018-06-11	{7,8,13,36,38,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ddf9d31a-9ca0-47a6-9b25-9bf8afcfc742	lotto6	1286	2018-06-14	{11,32,37,39,41,42}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f1a91356-e856-43e7-861b-a0a338259e6d	lotto6	1287	2018-06-18	{9,21,23,34,37,38}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
27642710-1cd6-4b18-a7fa-78f413fa2cda	lotto6	1288	2018-06-21	{8,9,19,24,35,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
100b740c-20fd-4c17-8262-35593f5e14fd	lotto6	1289	2018-06-25	{6,9,16,24,29,37}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4345780d-2f3b-4d64-861f-ec9a09f3bca4	lotto6	1290	2018-06-28	{18,24,27,32,35,41}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fed19a95-207a-44e1-bd05-347afab98958	lotto6	1291	2018-07-02	{2,6,8,12,13,17}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cc7d1bd1-5309-44bd-9913-b8ac5f853b6e	lotto6	1292	2018-07-05	{1,18,29,30,31,37}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a11c25f3-50a9-4d14-ac30-145bedf2485d	lotto6	1293	2018-07-09	{2,5,15,27,30,35}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dcc087e5-32c8-4507-a312-9d499a174608	lotto6	1294	2018-07-12	{7,14,18,26,28,39}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
196911bf-99b8-4e65-837d-df637ccc9c2b	lotto6	1295	2018-07-16	{14,23,31,37,39,43}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
05f8a98f-e230-4c0e-97f0-56679d49a8bf	lotto6	1296	2018-07-19	{5,11,15,16,23,32}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
71a7f98d-7466-4871-9d8d-b10375ecda48	lotto6	1297	2018-07-23	{1,2,7,29,34,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f73edeba-ea7d-4a1d-a30e-83d93e11cdd0	lotto6	1298	2018-07-26	{4,6,15,22,30,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
13a683dc-67cd-4a6f-87c5-ddef999bed77	lotto6	1299	2018-07-30	{3,12,24,28,38,39}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a38fc81d-4418-405b-a32d-efad736f2ce0	lotto6	1300	2018-08-02	{3,18,25,26,32,33}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
756014cf-f5f8-4453-a191-f20d398c17b6	lotto6	1301	2018-08-06	{6,7,9,16,30,41}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
51b59da9-0358-42ba-8463-a7137537ac3c	lotto6	1302	2018-08-09	{4,7,25,30,34,43}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0ed140a5-07cd-40a0-9fd4-4023f05122a2	lotto6	1303	2018-08-13	{7,10,24,33,35,42}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1539af80-567e-4350-bdfd-d3e9b92631ad	lotto6	1304	2018-08-16	{6,25,30,38,40,42}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
feb5d3e1-e333-497c-a7ec-7797f59831df	lotto6	1305	2018-08-20	{4,6,19,36,38,40}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1614472f-7dd9-4424-ac14-bb6cc00bdf1b	lotto6	1306	2018-08-23	{7,11,23,36,38,41}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bd31b70e-5df0-426a-811b-bd484257268f	lotto6	1307	2018-08-27	{6,25,27,28,30,43}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e2e02d8f-75ac-48b5-b136-2251b8474148	lotto6	1308	2018-08-30	{6,9,10,15,34,39}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8b39cac9-871d-4e3c-ad85-715bc381fa75	lotto6	1309	2018-09-03	{24,32,34,36,41,43}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3401624c-5de8-49ab-a386-6ac59a199199	lotto6	1310	2018-09-06	{9,24,25,27,34,36}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4628bd1f-ae6c-4a4e-8277-631c596679d3	lotto6	1311	2018-09-10	{12,23,26,29,36,37}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5cbbbf9c-faa4-434e-ba06-95ba5dc46ce8	lotto6	1312	2018-09-13	{13,24,25,26,32,39}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9a5a99bb-e0c0-4ce6-87dd-24110ab0af49	lotto6	1313	2018-09-17	{5,12,21,31,36,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
22696d38-a909-49ac-8f57-0bd3f4f7a2cd	lotto6	1314	2018-09-20	{3,10,20,21,27,33}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3662723a-9d37-4c71-acf7-74ac8594eedb	lotto6	1315	2018-09-24	{3,8,23,30,32,40}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
721478c2-0ff3-40a1-8245-cd29586942ac	lotto6	1316	2018-09-27	{6,16,26,35,36,39}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0e9942f6-42a6-4d22-a122-f9fee100ea4d	lotto6	1317	2018-10-01	{6,10,13,19,32,43}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b5424299-e0a1-458f-b542-ee47a09c4d9c	lotto6	1318	2018-10-04	{2,3,7,14,19,41}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dd044dec-446d-40ea-b0a4-1f71115b0bd6	lotto6	1319	2018-10-08	{9,10,19,21,28,30}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3dbdc52b-103e-4734-94c0-eacc871107d4	lotto6	1320	2018-10-11	{4,6,12,16,17,34}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e40f2f4a-0b41-4399-b6b2-ec83dcdcc80f	lotto6	1321	2018-10-15	{10,24,31,40,41,43}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
60e8e5df-d213-4649-875c-4a8c50276e46	lotto6	1322	2018-10-18	{2,3,13,28,32,37}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9e63a263-ce70-4eb2-aaf0-4c7a5f73d6e4	lotto6	1323	2018-10-22	{5,6,10,24,29,40}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ab64aae2-3cce-4207-ac0d-80b86f65624a	lotto6	1324	2018-10-25	{1,7,8,17,25,42}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5ec5fe0a-ac0c-4c04-90c5-c63763e14225	lotto6	1325	2018-10-29	{8,18,23,26,33,38}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
42514487-b8f8-42ef-b065-3599cfb2b6f4	lotto6	1326	2018-11-01	{2,3,9,12,30,41}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8686e0d5-aedc-465b-9c2a-5b240c98a503	lotto6	1327	2018-11-05	{2,3,13,22,23,30}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
64cac2e0-b462-4fac-9167-ddbc67115a6a	lotto6	1328	2018-11-08	{7,9,23,32,37,40}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8b4f025b-239b-49c3-9e96-d1136ca89cf4	lotto6	1329	2018-11-12	{11,15,18,22,37,42}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1a84f433-f897-4498-a4d2-a056f3246853	lotto6	1330	2018-11-15	{2,19,24,32,36,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e8094aa7-cb68-4f88-933b-6e6d947eb7c2	lotto6	1331	2018-11-19	{2,14,30,31,38,39}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
19418568-fd77-4027-9837-68eace07f0dd	lotto6	1332	2018-11-22	{5,15,18,22,33,40}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e5c2f656-3a95-4476-8a8f-2a25af00b252	lotto6	1333	2018-11-26	{2,9,15,22,26,35}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3de6b069-1085-472a-add1-07488890af76	lotto6	1334	2018-11-29	{1,2,7,14,29,43}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d591a1db-63c7-4a69-a042-beb23d1a64f2	lotto6	1335	2018-12-03	{10,16,19,34,35,39}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dec923a9-8633-4e9f-8de1-cfc9cc46ae9d	lotto6	1336	2018-12-06	{4,5,11,19,31,34}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
15694b86-46ae-4045-bc28-153debbd85da	lotto6	1337	2018-12-10	{3,6,21,28,29,34}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
761385fa-df25-4d07-9f80-0fb975f29677	lotto6	1338	2018-12-13	{2,6,23,25,30,31}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
50ed5f7a-79ff-4676-ab5b-abae71419d4c	lotto6	1339	2018-12-17	{1,10,15,33,34,42}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3eb4d6ac-e17b-49c4-94c1-6d3b318a2cac	lotto6	1340	2018-12-20	{6,15,18,20,26,29}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
72c1cd44-50aa-4643-8b46-4fb853140828	lotto6	1341	2018-12-24	{9,12,15,16,26,39}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
51b02411-1b28-4afc-9883-d2742c4a1be7	lotto6	1342	2018-12-27	{1,4,9,16,23,31}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bf06b3a7-6af5-420e-abcf-2cf151dcebc8	lotto6	1343	2019-01-07	{2,8,10,12,19,23}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
06adb7a7-52e5-406e-8c35-262bee9a1553	lotto6	1344	2019-01-10	{8,16,20,28,37,43}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b45c1814-aad3-4cef-a2e1-c6fe6e98b309	lotto6	1345	2019-01-14	{1,15,26,27,29,33}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
181559c3-08bc-49da-bfde-1002ce63d414	lotto6	1346	2019-01-17	{5,10,22,27,38,42}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
161c1f29-70ea-4497-b02e-97bea53a630b	lotto6	1347	2019-01-21	{8,10,11,18,36,43}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
924cbc92-dac5-46b1-888c-332080cbf63c	lotto6	1348	2019-01-24	{1,2,14,19,21,33}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fdd87106-00ee-4ac8-aecb-a6c659dc2566	lotto6	1349	2019-01-28	{2,16,19,32,34,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d6b5dadc-3adc-4726-af2f-0328e8097d9d	lotto6	1350	2019-01-31	{7,8,9,10,20,38}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5b4c7d09-a093-4f81-a78f-e30d1d721dc1	lotto6	1351	2019-02-04	{8,14,18,22,28,29}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cd142e3b-96b4-4047-9355-1fba91bf061b	lotto6	1352	2019-02-07	{5,6,9,15,19,36}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b250311b-94e5-4e3d-a5c6-a2085f2fba94	lotto6	1353	2019-02-11	{2,11,12,19,21,24}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
71f4a513-1c90-41b0-9650-dcddbe2be7f2	lotto6	1354	2019-02-14	{4,25,27,28,32,41}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4b75af4a-3734-4850-a409-7e7d0629816f	lotto6	1355	2019-02-18	{5,15,27,29,34,37}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0d3165fd-b23e-4a93-b321-f2ab2816e01b	lotto6	1356	2019-02-21	{4,6,10,16,24,43}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ed36d57c-a3a3-426e-be11-8c68d57d68e3	lotto6	1357	2019-02-25	{2,3,8,15,19,28}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d25e8b04-013a-4926-8ea1-d994b5d9049f	lotto6	1358	2019-02-28	{9,15,23,27,29,40}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c08dc416-c436-41e3-9f6b-6625975f1830	lotto6	1359	2019-03-04	{6,8,14,18,25,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0f5110eb-67fd-40b4-9ca2-d814ca20575f	lotto6	1360	2019-03-07	{4,9,10,16,17,42}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6de2abd6-3ee3-4ff4-a43f-d9f77968e935	lotto6	1361	2019-03-11	{3,4,12,18,28,38}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cbf0f5b0-ee15-4f8f-a345-89c7d932d153	lotto6	1362	2019-03-14	{8,16,19,28,36,39}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f7e98a64-f9ab-4903-abc3-2adce04ee71d	lotto6	1363	2019-03-18	{2,5,23,36,37,41}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5b9d9b57-84dc-46d5-919b-11073fe69ed6	lotto6	1364	2019-03-21	{5,13,14,16,25,27}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
43811c86-7a36-4ec3-a402-00f95dbbe553	lotto6	1365	2019-03-25	{4,7,14,20,31,41}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
362d4c50-e843-4c86-aa83-0db96e831ea4	lotto6	1366	2019-03-28	{14,15,17,29,31,39}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9afd5679-e0ff-413f-a7b2-8c9f7c30f0be	lotto6	1367	2019-04-01	{3,8,11,14,22,41}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4bbc80d2-111c-416f-8586-9dcd6799edd8	lotto6	1368	2019-04-04	{6,11,17,20,34,35}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cd3a0a76-9b5f-4aa2-8100-2b284c180cf0	lotto6	1369	2019-04-08	{12,15,25,32,41,43}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8dca4a48-0953-41e3-9bda-df5944264acb	lotto6	1370	2019-04-11	{8,22,24,30,40,41}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e6a0e064-0ae7-4043-a291-f561e38c1ce4	lotto6	1371	2019-04-15	{4,5,6,7,24,28}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
feeafcb4-1ad0-4991-a628-260622433fd3	lotto6	1372	2019-04-18	{3,5,10,21,33,39}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dcb83047-d181-4ae4-8a18-f6c9165e1cfe	lotto6	1373	2019-04-22	{1,10,13,18,20,41}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9f025988-b831-4079-be7a-5166b783a01a	lotto6	1374	2019-04-25	{1,4,5,19,23,35}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9900ca94-a6ea-4b93-917e-9648f37d168a	lotto6	1375	2019-04-29	{2,5,21,22,31,38}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
70be03d7-c2e6-40ba-8c06-e0bf3f80d673	lotto6	1376	2019-05-02	{2,5,22,31,32,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fe5470c3-cb0a-4354-beaf-7736b4d14408	lotto6	1377	2019-05-06	{1,7,13,24,40,43}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
79399947-759c-4422-b577-6852ce18482e	lotto6	1378	2019-05-09	{1,10,15,24,35,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
32887123-8dbe-494d-8546-4658b9133ebd	lotto6	1379	2019-05-13	{1,2,19,21,24,37}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d39a44a2-a81b-48f2-875e-77acb675c886	lotto6	1380	2019-05-16	{1,3,24,26,29,33}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8c5ce682-0f90-4c28-b506-3b345649cfb6	lotto6	1381	2019-05-20	{2,4,5,16,19,38}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
08183ff0-3ea2-47d0-af5c-e43100dd3484	lotto6	1382	2019-05-23	{8,9,12,25,26,28}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
93980cf0-da49-4df5-b150-f7c287142482	lotto6	1383	2019-05-27	{2,4,9,15,18,39}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
885ae02c-9b58-4ba6-8643-c3d3cc5178e6	lotto6	1384	2019-05-30	{3,6,13,32,38,43}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1ad096c6-e7e2-4456-89c7-40dc404d910f	lotto6	1385	2019-06-03	{9,20,28,35,41,43}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cc9bcc19-ac82-4097-a121-be5a8f875925	lotto6	1386	2019-06-06	{4,11,14,15,20,38}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cf3647ac-1e70-4382-9726-56fba1439a15	lotto6	1387	2019-06-10	{11,27,29,30,37,38}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
178c8bbf-9ce0-4236-a96f-8cd07ec81732	lotto6	1388	2019-06-13	{9,10,12,15,29,37}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
510e93b3-7326-402d-8aa4-9783483a8d44	lotto6	1389	2019-06-17	{6,16,21,23,26,42}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6e74221e-ccc7-4439-a7f4-84cb52c8ab98	lotto6	1390	2019-06-20	{10,11,13,28,34,39}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
eed53c51-031d-47a4-9820-7d26b2e66c0f	lotto6	1391	2019-06-24	{3,12,23,31,36,42}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
449e07fe-4d16-499a-9425-8689c7a651d3	lotto6	1392	2019-06-27	{6,9,12,19,40,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1dedaaad-c679-4d44-b10a-2eb9e0bb5237	lotto6	1393	2019-07-01	{7,11,26,32,42,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
60be2ad0-8b69-4cfd-9238-10ac5bf3e01e	lotto6	1394	2019-07-04	{8,9,35,36,42,43}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
deaf9b6b-a6d9-4bd7-8031-f51596ebfecb	lotto6	1395	2019-07-08	{5,16,18,27,30,43}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0af71f6d-0fb9-4f40-83bd-a9adf71aa18b	lotto6	1396	2019-07-11	{3,7,11,15,23,41}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
103f6493-8964-45e1-a1dd-469e581ae961	lotto6	1397	2019-07-15	{9,18,19,21,25,26}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
72be5d13-084c-43ff-b305-995db945c7b3	lotto6	1398	2019-07-18	{23,29,34,35,40,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cc0f000f-5f23-4ed1-af76-4badd7017fa0	lotto6	1399	2019-07-22	{7,20,21,33,41,43}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a8a90e7d-9654-47b6-9c11-87bd370d758a	lotto6	1400	2019-07-25	{8,10,26,31,34,39}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c219179a-b4e0-466e-88c4-f4bdea4aa956	lotto6	1401	2019-07-29	{2,13,23,24,25,33}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fb387e59-2cfd-48c6-a10d-591e6e9b586c	lotto6	1402	2019-08-01	{10,24,26,33,36,42}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b6960e11-5abf-403f-b193-3276710ac7d1	lotto6	1403	2019-08-05	{1,3,10,27,34,41}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
28efb2f9-5afe-4c2c-911c-dcb38c2440ee	lotto6	1404	2019-08-08	{2,17,29,37,38,39}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
24e5ab97-15da-4846-81d8-7e0b48076ad1	lotto6	1405	2019-08-12	{3,4,6,19,23,24}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f061cb33-377f-4a0a-9207-e0e0264300c5	lotto6	1406	2019-08-15	{20,24,27,29,34,35}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
05806ab3-1ec1-47c1-9275-a23e3fd8a99a	lotto6	1407	2019-08-19	{10,13,19,28,33,39}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ad8a78b2-3488-4768-8ad1-25361ce31fe2	lotto6	1408	2019-08-22	{2,17,24,26,34,43}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e1777c62-648b-40ad-9950-cadd14518ff3	lotto6	1409	2019-08-26	{5,6,8,20,22,25}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6268ddcf-4371-459b-b038-ecb1c5d84de9	lotto6	1410	2019-08-29	{8,14,17,25,36,41}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3265b74f-b2b7-43ad-a036-466024364096	lotto6	1411	2019-09-02	{2,5,7,20,25,28}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9d631fed-4e07-4b9e-8847-502ac482d1e2	lotto6	1412	2019-09-05	{2,19,24,25,32,42}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a47aab5b-1919-4057-a380-351c237181d3	lotto6	1413	2019-09-09	{7,13,17,21,24,26}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
94d9935f-11a2-4287-9e40-19849e2900cb	lotto6	1414	2019-09-12	{12,19,21,26,40,41}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f5475e77-50fe-420a-aea7-133872effa9f	lotto6	1415	2019-09-16	{1,3,7,34,39,40}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
197db727-a0a6-4a68-b4ca-a4a45d64fdab	lotto6	1416	2019-09-19	{2,9,10,15,24,36}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
438a8c1e-841c-4f77-9d89-2845ec39448f	lotto6	1417	2019-09-23	{3,10,25,26,27,31}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
858372e8-00bf-434d-9c20-131dff750ba8	lotto6	1418	2019-09-26	{4,21,32,35,42,43}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
262535f5-a29d-43e7-905a-3b0c2135eebe	lotto6	1419	2019-09-30	{5,10,11,12,21,37}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c32544d2-c2b6-4c7c-961d-226cb2673f82	lotto6	1420	2019-10-03	{1,2,14,16,22,28}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6fcc2f8f-af0e-4957-b7b5-1d7aa338b373	lotto6	1421	2019-10-07	{2,14,20,23,37,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
15bc1d17-1b0d-48f6-9b1e-16457f55f2ae	lotto6	1422	2019-10-10	{12,14,17,20,24,30}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
624e7713-3b38-40e5-a5c4-a147a4a1f6d7	lotto6	1423	2019-10-14	{11,24,29,36,37,42}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
407adf30-11f5-4cdd-8c10-ba8768c925b8	lotto6	1424	2019-10-17	{6,7,25,26,33,36}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d666146a-e444-46e5-bffb-ce79452d6054	lotto6	1425	2019-10-21	{1,24,28,33,35,42}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f10f5fbf-3d46-4b17-8853-fa88747b09a6	lotto6	1426	2019-10-24	{4,13,17,19,30,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
77bdbcd5-73aa-4545-807b-64c5ba931fd7	lotto6	1427	2019-10-28	{1,7,25,26,38,41}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
beee91d0-ea65-4c68-89b6-e126436d512e	lotto6	1428	2019-10-31	{16,18,19,34,35,36}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c6fd0a00-7633-4e53-994b-4e1f14972ba8	lotto6	1429	2019-11-04	{4,8,13,18,21,23}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
42e83073-9764-41ff-bc24-6d06ec963ce5	lotto6	1430	2019-11-07	{4,7,9,12,20,28}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9490b5f0-b39a-4436-94c3-163bc2928772	lotto6	1431	2019-11-11	{2,27,28,33,38,40}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b5eb00e0-7f59-4caf-8649-497e8a95d608	lotto6	1432	2019-11-14	{4,5,15,32,33,43}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5ecb034c-b198-4a9e-b06e-8b568f27bd39	lotto6	1433	2019-11-18	{3,5,12,16,38,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9c53b266-3844-4f50-89ff-0c45e00a934c	lotto6	1434	2019-11-21	{2,20,30,38,39,40}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0ff3da60-48a5-4468-b6dc-0694f30dc9a0	lotto6	1435	2019-11-25	{2,4,16,21,22,40}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1a420246-5609-4b21-a1ca-ed0683ac4da6	lotto6	1436	2019-11-28	{3,7,17,18,30,36}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dcc0d1f8-cfb9-4a6d-96b5-35c4254a4178	lotto6	1437	2019-12-02	{3,11,24,25,37,40}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
17f73402-2487-4b97-aa5f-85a4ad3de774	lotto6	1438	2019-12-05	{2,5,6,20,33,38}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7fedcf7d-fe2c-4d8e-8490-a31cf08b918e	lotto6	1439	2019-12-09	{11,17,23,28,34,41}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d304b1cd-1776-464c-9392-b654dd1cec5e	lotto6	1440	2019-12-12	{1,7,20,31,41,42}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2d7b3dd6-dd06-4a1f-a7db-e28a3e07156f	lotto6	1441	2019-12-16	{12,22,24,33,35,42}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
918e429e-9d12-44f3-932d-a38caef098f7	lotto6	1442	2019-12-19	{12,21,35,36,40,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
38b037d0-5615-47c8-bf0e-897519ebe69b	lotto6	1443	2019-12-23	{2,4,8,10,22,33}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8951ce76-976f-499d-a633-338a3a006961	lotto6	1444	2019-12-26	{11,20,24,25,30,37}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d54a2d92-86f9-4557-86a2-d7837e673e06	lotto6	1445	2019-12-30	{3,14,24,29,30,42}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1569422d-9045-4eea-833a-ab75c06d9240	lotto6	1446	2020-01-09	{2,5,11,20,21,32}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8ddc38e9-6eeb-4272-8926-83ed10133c97	lotto6	1447	2020-01-13	{2,9,12,13,14,22}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
545af250-ddfa-4d90-9f62-ed3a2e361a2a	lotto6	1448	2020-01-16	{10,12,25,29,32,41}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2cc93c7a-f4d5-4fbd-a660-a43664b84af6	lotto6	1449	2020-01-20	{6,19,20,26,34,38}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e7b3a527-c29e-4baf-b617-f4e0414d5aaa	lotto6	1450	2020-01-23	{24,25,26,27,34,36}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bc354465-0e89-4527-b230-b16d9576f9bc	lotto6	1451	2020-01-27	{2,6,10,20,24,43}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
304bc8d6-8b0e-41ba-98e9-eb4b92edecc0	lotto6	1452	2020-01-30	{17,19,29,31,37,39}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9ba2eb94-ac3f-4398-a393-ec66ee97aa23	lotto6	1453	2020-02-03	{10,22,26,27,28,41}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1ba27b55-b757-4b9f-8c79-312427e79639	lotto6	1454	2020-02-06	{3,15,19,34,37,40}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b9c39887-831b-42a6-8dfb-0c438aef0714	lotto6	1455	2020-02-10	{1,10,12,22,34,43}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f5f16eae-0a5d-46b6-b81b-a88dfb0e820a	lotto6	1456	2020-02-13	{2,18,19,24,29,31}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d198e44b-b16b-416d-9fce-4f36712c6e1c	lotto6	1457	2020-02-17	{1,3,11,17,20,37}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b2b6fcf9-7f24-48e1-8cf9-36f9db7a7b99	lotto6	1458	2020-02-20	{4,16,19,22,26,29}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
83a92a71-f55f-415b-b053-a5888e016c76	lotto6	1459	2020-02-24	{2,17,19,24,28,29}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
939117ab-c019-4fe5-88ee-bdb4e0342e08	lotto6	1460	2020-02-27	{3,6,10,15,29,30}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
01009453-30ac-4499-aa6b-41c2df661352	lotto6	1461	2020-03-02	{5,7,8,18,22,26}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
407e42f3-8213-4310-9aff-93e64b1c5bfc	lotto6	1462	2020-03-05	{4,18,19,28,33,36}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d0bd18e5-29fd-47c4-9423-6f1c6571c3d8	lotto6	1463	2020-03-09	{18,29,32,34,35,39}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
078bff7f-3955-46c3-af78-cc38e59a6ad3	lotto6	1464	2020-03-12	{8,13,14,18,29,31}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7588b6dc-1719-4e0c-86bf-d2a23233818a	lotto6	1465	2020-03-16	{11,15,16,24,28,38}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
98389830-77d7-46fb-ad6c-c70a5e8f7ab4	lotto6	1466	2020-03-19	{6,10,15,18,32,40}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3062f3bf-c690-4946-af46-0bcde6c039e2	lotto6	1467	2020-03-23	{3,14,16,25,26,38}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
71e3fda8-fda1-444a-85b8-2b6f3c86c7d6	lotto6	1468	2020-03-26	{4,8,15,24,25,31}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
400ad411-690f-4121-b003-26537e764e1c	lotto6	1469	2020-03-30	{4,9,10,13,24,27}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5fc00dd8-0591-48ce-88d9-f43fbafd1659	lotto6	1470	2020-04-02	{4,8,14,16,39,40}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6aef6eee-c2ab-480b-a4a2-21bbfa0c8fb9	lotto6	1471	2020-04-06	{1,3,8,32,37,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
02a9cbc9-e202-41d0-ad86-a89bec85400f	lotto6	1472	2020-04-09	{1,6,7,9,23,40}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
07b037ac-bc4e-42bc-85b7-27eec64ceb1c	lotto6	1473	2020-04-13	{1,5,6,27,33,38}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0ba9f969-6383-4f4a-b8b4-c4a351ad972a	lotto6	1474	2020-04-16	{4,6,8,22,27,32}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0411cdaf-5a23-4077-8073-a86780517996	lotto6	1475	2020-04-20	{6,7,9,20,21,27}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
61832037-8275-4bf5-ba61-3f8f1167c37d	lotto6	1476	2020-04-23	{6,22,38,40,41,42}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7935401f-7b32-42f7-938a-874caceaf786	lotto6	1477	2020-04-27	{4,13,14,25,27,32}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9e16e8f0-d659-4fa0-9e67-8ab93a6f1f4a	lotto6	1478	2020-04-30	{7,12,15,21,40,42}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cfc0c3c5-0a27-4376-ad9d-a15a11e74258	lotto6	1479	2020-05-04	{1,20,30,32,35,37}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ccd76b8b-ed90-4a20-88fe-28234582615c	lotto6	1480	2020-05-07	{2,4,5,6,24,34}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4ff6e1d7-d48b-49bd-bedf-0532f996b382	lotto6	1481	2020-05-11	{3,9,21,31,41,42}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0f2ccff7-5443-4fa8-8013-74b1a90568ea	lotto6	1482	2020-05-14	{8,26,28,32,41,43}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7cde025e-05af-4ba7-a86f-a093ff48f841	lotto6	1483	2020-05-18	{3,10,20,23,29,43}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
52265127-038d-42ae-9af1-2ffe95c46b26	lotto6	1484	2020-05-21	{4,12,17,18,23,41}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9389e573-2b9c-40ab-b071-f9e9ce86023f	lotto6	1485	2020-05-25	{9,10,18,27,28,35}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
61e60a41-b438-4a73-a42b-9bcc2ba84797	lotto6	1486	2020-05-28	{18,24,29,33,39,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
45e31a99-f987-4896-9e98-2e7819003d21	lotto6	1487	2020-06-01	{5,7,9,17,24,35}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7e64a44e-ef56-4e2a-a8ce-a8e107836f27	lotto6	1488	2020-06-04	{4,10,11,17,34,37}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8b291de8-f636-4049-9572-9e5e86ddf0d2	lotto6	1489	2020-06-08	{4,6,11,13,23,32}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
95893a24-ca82-4d29-84b9-c52fdac46058	lotto6	1490	2020-06-11	{7,19,24,29,39,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ae1748f6-1b01-45ea-b842-4065ebff33c4	lotto6	1491	2020-06-15	{8,11,23,31,34,37}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
68eb36c6-c088-40f7-a964-4531d9a6fc61	lotto6	1492	2020-06-18	{4,16,18,32,38,42}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f0e677b4-8861-4f5a-b78d-895e08616338	lotto6	1493	2020-06-22	{11,18,24,27,37,38}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
422c39b0-aec5-4842-8451-900197d87608	lotto6	1494	2020-06-25	{8,15,17,24,26,38}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d9e764b8-0334-4551-9b7b-e41a6d10cccc	lotto6	1495	2020-06-29	{18,24,32,34,37,41}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5446225e-f22b-4988-bd18-e7848095eab1	lotto6	1496	2020-07-02	{5,9,13,16,17,34}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2405cdb2-3351-41ef-bb1d-723c498c1a22	lotto6	1497	2020-07-06	{6,22,28,30,35,37}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a8a6f4de-0b4e-4117-9da7-bce9017ba267	lotto6	1498	2020-07-09	{1,6,7,9,31,37}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
801c0000-d76c-4125-9daf-70aaa580bdef	lotto6	1499	2020-07-13	{10,11,27,28,29,37}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3d35335c-475e-44ba-9397-7a40cf3dbefe	lotto6	1500	2020-07-16	{19,21,22,28,29,30}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f5d4bb09-bebf-4a8a-aa3a-4a0ad8465f07	lotto6	1501	2020-07-20	{6,10,13,25,31,38}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1109c7c5-3772-45bc-a947-0778537d47da	lotto6	1502	2020-07-23	{1,17,25,28,32,42}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
09166f74-ed95-4263-82c0-f2c5c608c6ad	lotto6	1503	2020-07-27	{1,8,16,35,40,42}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d35e489a-edbd-4680-af41-be42dc5cfcc6	lotto6	1504	2020-07-30	{5,7,9,21,42,43}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
595e6405-c9ce-4347-a207-5a9200f365f0	lotto6	1505	2020-08-03	{1,2,14,15,21,34}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1a1fc81f-0356-4427-b040-c8fe7fab674a	lotto6	1506	2020-08-06	{10,12,19,28,35,41}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6733846e-4ebe-4271-8098-928bdb51d705	lotto6	1507	2020-08-10	{19,20,22,30,35,43}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a71fc734-82bf-4923-ad84-c63f1b0c59ef	lotto6	1508	2020-08-13	{9,13,28,29,32,40}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b6d56e97-df3e-46e7-a115-87282af61e6f	lotto6	1509	2020-08-17	{6,11,12,34,36,41}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1a7c5f23-f4e0-41a7-a56d-6a23d781c0bc	lotto6	1510	2020-08-20	{8,13,17,18,21,38}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b6d31da9-832a-4714-9c1f-0f678e7a648a	lotto6	1511	2020-08-24	{11,16,22,24,38,40}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5ecbef83-78eb-4b21-be7e-78cf8ed0f667	lotto6	1512	2020-08-27	{1,11,12,24,32,38}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4317cdb5-7f32-46b5-bd13-6683710855a5	lotto6	1513	2020-08-31	{13,14,18,19,25,42}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3d95f6de-c79f-4f95-b07f-3cfa7b70fea6	lotto6	1514	2020-09-03	{11,16,22,29,37,43}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5ab3474e-6d4d-4666-b7cb-6728afc63955	lotto6	1515	2020-09-07	{5,9,17,21,27,29}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cc437a9a-8d87-4b0d-ad35-8871e5c37e61	lotto6	1516	2020-09-10	{25,32,34,37,41,42}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4be7b22e-3106-484c-8396-d7b73602e6c0	lotto6	1517	2020-09-14	{14,25,27,30,39,41}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7cd14fa8-c5bd-465d-96e1-73c9aab45792	lotto6	1518	2020-09-17	{6,15,16,22,36,41}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5a5b5b97-4138-418d-93dc-0a9efef82d41	lotto6	1519	2020-09-21	{5,8,20,21,27,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
744c4d40-da82-4565-ae63-3db13adf9879	lotto6	1520	2020-09-24	{1,6,11,13,30,33}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fa9179da-a8cd-4498-87ab-decfb507683d	lotto6	1521	2020-09-28	{17,21,22,40,41,42}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4414ed56-5e1b-4336-bd7c-4d36a6357eee	lotto6	1522	2020-10-01	{5,17,21,22,32,35}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b0a2800c-cc46-45be-9ff6-c38e1684d360	lotto6	1523	2020-10-05	{2,15,17,25,34,38}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3e3aaa35-171c-48e7-b082-fc0f3b619815	lotto6	1524	2020-10-08	{2,3,15,24,30,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9528161a-b24d-4482-baac-7e61929674e2	lotto6	1525	2020-10-12	{3,7,20,21,28,32}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cdb9807c-ed1b-4f29-852b-ebd950acb70d	lotto6	1526	2020-10-15	{4,17,19,21,39,41}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
eaf94fda-9b94-41f1-94e3-d8f9bf4c5037	lotto6	1527	2020-10-19	{2,5,9,11,27,32}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d85513cd-fe4b-4777-8a7e-aca7a1897559	lotto6	1528	2020-10-22	{1,14,17,34,35,37}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6d2479b2-2d42-45bb-945c-f32557693e09	lotto6	1529	2020-10-26	{3,19,26,28,33,40}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
99693b8e-fd0c-4d7d-b0b3-3651613c36ad	lotto6	1530	2020-10-29	{2,5,10,34,37,40}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
eb6f38f0-9a5d-479b-b6a9-2ffd8c871fa9	lotto6	1531	2020-11-02	{2,6,7,10,30,33}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b0bb1616-f416-4568-9a58-c05dfc845da5	lotto6	1532	2020-11-05	{2,9,14,16,17,21}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
60465d6d-a768-4b38-8a88-dbb5cdf4800a	lotto6	1533	2020-11-09	{15,22,27,37,38,41}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e05e178c-f1d1-4b62-82ae-43e6d40806ac	lotto6	1534	2020-11-12	{1,9,18,22,24,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4edcdc07-636b-49f3-9398-29cd17b2ed84	lotto6	1535	2020-11-16	{1,9,14,30,35,38}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
56ab9ffe-810a-4d85-9833-9849aaab11d7	lotto6	1536	2020-11-19	{2,5,9,30,37,40}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c15b00f9-52fc-41ec-af34-d0c509ccde0d	lotto6	1537	2020-11-23	{6,13,14,32,33,37}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
384b5027-1b3e-461e-ae7e-9b22ed11a6e7	lotto6	1538	2020-11-26	{8,14,19,33,35,40}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3095f33d-35af-4c3d-a26c-9d823be88ea4	lotto6	1539	2020-11-30	{13,29,33,37,41,42}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7b3c1a6f-98f6-4632-8c00-8099f9736e89	lotto6	1540	2020-12-03	{1,20,25,28,33,37}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d0ec46b7-6583-4cc0-82fb-02b22b4df449	lotto6	1541	2020-12-07	{12,26,28,32,33,35}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e1782041-6748-4547-a7bd-30e95f67abe0	lotto6	1542	2020-12-10	{11,12,16,17,20,36}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ac4f1199-5cb0-4d4c-9740-36535b233228	lotto6	1543	2020-12-14	{17,21,26,33,36,38}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
47a0d0e2-81cf-4063-aa0b-d32bff77856e	lotto6	1544	2020-12-17	{3,11,25,26,39,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fae1fac1-3c5f-4b47-bd3b-7207e37b2c3e	lotto6	1545	2020-12-21	{8,14,15,26,37,43}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a15f1d39-ee58-454c-8a4c-d8250ca09b4c	lotto6	1546	2020-12-24	{1,18,19,24,31,40}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e4d93a4d-bde0-4c47-8668-214fcd5c1a0a	lotto6	1547	2020-12-28	{4,11,14,17,22,39}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a50da3dd-bba5-4c35-bbbd-787d337ee93d	lotto6	1548	2021-01-04	{18,24,26,35,39,42}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f883f354-e21e-4c9a-8fad-9a5b34d12b9d	lotto6	1549	2021-01-07	{4,5,27,28,35,41}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8de14f6f-bd00-4183-a200-7dd3069987ca	lotto6	1550	2021-01-11	{8,11,22,32,37,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
817040e4-21d4-4537-a718-64e208637f1a	lotto6	1551	2021-01-14	{3,14,18,24,38,43}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9c6904e5-a6bb-430b-9dd0-48fb6ee21b57	lotto6	1552	2021-01-18	{5,9,15,30,32,39}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2ba7c835-216b-4238-82b7-1c75850db49f	lotto6	1553	2021-01-21	{7,8,16,32,41,42}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f9a0ae39-a209-414e-82cd-f7b219ca9886	lotto6	1554	2021-01-25	{6,14,16,27,40,42}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d7b22fc5-e640-4a47-b6c5-2a20e9f29e81	lotto6	1555	2021-01-28	{2,8,17,23,24,27}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d1bb1885-9456-4bd0-a510-59607154f59f	lotto6	1556	2021-02-01	{10,19,28,30,38,42}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e57ad869-700d-4640-a879-b3a4c57df690	lotto6	1557	2021-02-04	{5,21,22,23,26,39}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
07c1925f-93f0-4df1-a8a7-8713bd2a27dd	lotto6	1558	2021-02-08	{1,12,25,27,39,42}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0467987c-d861-4a8f-a042-931121e424c5	lotto6	1559	2021-02-11	{4,15,17,20,26,31}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
79cb640b-babb-4b85-b3be-8f4f62d06d3e	lotto6	1560	2021-02-15	{7,19,24,32,40,42}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2aeab816-d541-4d42-87de-d5008b9421d7	lotto6	1561	2021-02-18	{12,15,26,34,35,38}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6bc7ee9e-8b0f-4cc1-960a-64c09a9d3615	lotto6	1562	2021-02-22	{2,4,15,16,26,33}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f69757f9-a115-4579-96d9-f86ac59f6394	lotto6	1563	2021-02-25	{1,12,20,26,35,37}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0fa90583-c145-4681-b120-dad209e9aca0	lotto6	1564	2021-03-01	{5,6,18,20,27,37}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e9e30bb3-f627-4cd6-acbb-7df89bd3e710	lotto6	1565	2021-03-04	{5,9,17,28,30,37}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dab8554d-1564-4893-8a9e-ff779d929bdb	lotto6	1566	2021-03-08	{12,13,20,24,30,35}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b5987cf7-a092-4e80-9d0b-ba4e426ef7a3	lotto6	1567	2021-03-11	{5,7,19,26,37,40}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
18c8cdf0-e3f8-4d99-ab8d-9e8ec3a21cc5	lotto6	1568	2021-03-15	{2,5,7,10,16,34}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d070bf3e-3e9e-4059-b97a-de9ba62fd8dc	lotto6	1569	2021-03-18	{2,8,29,31,32,33}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
703bb958-4215-488c-8ad1-5ed498a68fd8	lotto6	1570	2021-03-22	{1,19,22,23,31,36}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b95aed11-8691-49ef-90d5-86feb6673b67	lotto6	1571	2021-03-25	{1,2,5,25,40,41}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1e782468-0404-4ba1-802f-dc8ec0a5a58f	lotto6	1572	2021-03-29	{4,6,10,19,28,38}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
35794854-c1e6-4527-92f3-df39d7ae5efa	lotto6	1573	2021-04-01	{2,10,16,38,39,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6b61ea53-5ecb-44b2-b8e5-046e12ffb3c2	lotto6	1574	2021-04-05	{1,2,3,20,31,32}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ba686c9b-704f-4370-ae4c-f882d2bbd2d4	lotto6	1575	2021-04-08	{2,8,15,24,32,39}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c0403f2a-be90-45d6-83c5-6593133d8e5d	lotto6	1576	2021-04-12	{5,7,10,17,29,32}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
99363b82-7c15-4f3b-9bc0-5a9619df72c2	lotto6	1577	2021-04-15	{13,14,15,28,37,39}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
50aac672-46ef-451d-bd95-b8688ec40d91	lotto6	1578	2021-04-19	{3,15,17,19,21,34}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6b814e24-0a3a-47c3-be1c-9f7b1578d7d3	lotto6	1579	2021-04-22	{23,29,32,33,37,42}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a4772bbd-e82e-482a-b110-c468dfb8ff20	lotto6	1580	2021-04-26	{5,7,11,12,24,31}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3254569f-b928-4d2c-a8b3-07549b15a461	lotto6	1581	2021-04-29	{6,12,30,31,41,43}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9e9376b6-c2c8-4fe2-9d7e-5bd6c4631f67	lotto6	1582	2021-05-03	{18,32,35,36,39,41}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4ffdf1fb-aa56-4479-baec-cfb80d8b7de0	lotto6	1583	2021-05-06	{5,7,16,34,39,41}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1485187d-c39c-4b48-aaaa-e77ace42d898	lotto6	1584	2021-05-10	{13,15,18,30,37,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3d8a727b-1d9f-457c-85b9-7648a793cf85	lotto6	1585	2021-05-13	{2,6,10,13,16,32}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2024e4e1-e5e7-4dc1-9d3c-ef7b82e8ed75	lotto6	1586	2021-05-17	{2,13,19,27,40,42}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8c67227f-fb80-44d8-bc77-4c9c2f8514ea	lotto6	1587	2021-05-20	{16,21,22,27,36,43}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c6369390-d7a0-4887-8c48-1ee06fe2d491	lotto6	1588	2021-05-24	{6,16,27,31,32,34}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
589bd33f-e9e9-48c5-9a41-518f6a9b4cae	lotto6	1589	2021-05-27	{11,21,25,31,36,39}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
eb600276-062e-4b12-bf28-1f1b0bbed270	lotto6	1590	2021-05-31	{10,12,15,29,33,42}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7500eab5-08d7-4fef-982b-413511aaedc6	lotto6	1591	2021-06-03	{7,9,18,21,26,43}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
231e1345-1f09-4923-8430-0e759ab68c1b	lotto6	1592	2021-06-07	{4,16,25,30,36,43}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5971b67b-fb41-4c19-8ba4-1a3d6e77703f	lotto6	1593	2021-06-10	{6,17,18,35,37,38}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7e432943-58b0-498c-9794-1a43c4c0db9c	lotto6	1594	2021-06-14	{1,5,6,13,34,36}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b6845255-25f7-43a9-ba21-6b88c9fa6bed	lotto6	1595	2021-06-17	{16,21,30,32,40,43}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1ce7d9c3-9135-4651-87bf-868a7eb70c74	lotto6	1596	2021-06-21	{10,15,30,35,42,43}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
89978a10-c52b-451f-b7a7-b8499bac0327	lotto6	1597	2021-06-24	{2,3,8,17,23,32}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5ace5382-6839-4e1d-9613-65a48b39fef1	lotto6	1598	2021-06-28	{9,11,26,28,39,43}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
df9261c3-b849-407a-9409-2b26d020f3cf	lotto6	1599	2021-07-01	{1,2,20,22,35,38}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1ab2b2f2-b08c-4ba1-85a7-7b248fa25fb2	lotto6	1600	2021-07-05	{7,14,22,35,37,39}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ea3e66cf-1006-44fb-97e8-bf9bde09ec9e	lotto6	1601	2021-07-08	{6,13,17,18,21,41}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
36a2defb-a02a-477b-8116-d73ab0d0f5cd	lotto6	1602	2021-07-12	{1,2,7,14,32,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ed050072-b543-425f-92f0-22d9dac288fc	lotto6	1603	2021-07-15	{4,6,32,35,40,42}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cf6702f2-2bab-4374-ab26-2357469a0d81	lotto6	1604	2021-07-19	{12,21,23,36,37,38}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
29649d8d-47dd-4d97-ace7-a659647e0202	lotto6	1605	2021-07-22	{2,5,8,20,29,40}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0107fd57-ed77-4d51-b16e-b07c9f78e021	lotto6	1606	2021-07-26	{18,23,25,26,32,34}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
928449bd-32c2-4546-8199-68210030c1e0	lotto6	1607	2021-07-29	{10,13,14,15,17,22}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
61796c57-9e80-4dad-8c8e-d7915c9543d6	lotto6	1608	2021-08-02	{10,18,22,23,25,35}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d8c64528-5a6f-4aed-90b6-4a77e192c83a	lotto6	1609	2021-08-05	{4,12,16,34,35,41}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
75244eda-7cee-4661-bfe7-3951dbec9d2f	lotto6	1610	2021-08-09	{1,8,13,22,41,42}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cb1c0fad-fe77-4dad-9510-682b61730425	lotto6	1611	2021-08-12	{3,14,16,24,32,36}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ae68623b-9fc5-4911-b05d-9d31b03106cc	lotto6	1612	2021-08-16	{5,8,12,16,27,38}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6593d63a-1eaf-4fc0-8735-a06441b0015d	lotto6	1613	2021-08-19	{9,17,22,25,30,41}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
96ff2da0-4391-43b8-9a45-94e8f54bc1f6	lotto6	1614	2021-08-23	{4,5,20,29,40,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c8c91aee-2b11-4793-8c03-e242035df0d4	lotto6	1615	2021-08-26	{2,5,6,13,19,29}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cb6a1038-6aea-433e-8924-41813890e3a2	lotto6	1616	2021-08-30	{1,4,6,21,34,41}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a631e255-5e53-4a86-88b3-2caccfebed65	lotto6	1617	2021-09-02	{2,19,21,24,26,41}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
816d55c2-4bbe-4b4c-9984-66f8d83a827c	lotto6	1618	2021-09-06	{2,10,14,17,37,43}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
427c80a0-6bd0-4b47-92b1-bb632133f1ff	lotto6	1619	2021-09-09	{3,5,17,20,24,38}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b1773650-9082-446d-a5e7-5d9c36c90b9f	lotto6	1620	2021-09-13	{7,15,19,24,25,28}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a2a9dfab-6c1a-4ab6-832c-6ec2c9788cd5	lotto6	1621	2021-09-16	{3,10,22,23,26,39}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
24be0653-5606-42d3-8a07-9f3df70ced3e	lotto6	1622	2021-09-20	{16,29,34,35,40,41}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5172166c-239d-46a1-9348-010705b5e927	lotto6	1623	2021-09-23	{7,12,15,17,19,29}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b1564920-7b58-4a89-848f-0ce27dae42be	lotto6	1624	2021-09-27	{3,5,17,25,33,39}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
36181adf-4e66-4cac-b353-e3d2c556e996	lotto6	1625	2021-09-30	{1,4,8,11,30,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
551e72eb-3228-4345-9e33-bb05f6b80db7	lotto6	1626	2021-10-04	{9,11,19,23,30,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
28ed823c-7af7-4fd0-9fbb-93c0428f0ff8	lotto6	1627	2021-10-07	{21,22,23,26,36,38}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
18837c39-d303-4122-86af-0c1ec8e6a507	lotto6	1628	2021-10-11	{1,3,10,12,26,42}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
18cbd184-a6d9-48a6-9b02-567b8f616048	lotto6	1629	2021-10-14	{19,23,30,31,32,40}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7c1dec07-c62a-482c-b696-e0e7fcae7be9	lotto6	1630	2021-10-18	{10,11,24,33,34,36}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dd5b07ef-d4d6-4373-81d4-7461c2ea57e8	lotto6	1631	2021-10-21	{7,15,23,26,30,35}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d97e6f58-0e4b-46e2-aee4-ffe6fa104cbd	lotto6	1632	2021-10-25	{1,9,24,28,31,41}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4d8abfab-175c-4d6e-9ce0-ffa7f6e4d40b	lotto6	1633	2021-10-28	{3,7,9,26,35,36}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
31b4c3de-50a4-4862-95ea-ab3ded20bafb	lotto6	1634	2021-11-01	{18,19,20,23,29,35}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
36919065-037c-455b-abd7-2e331fc11352	lotto6	1635	2021-11-04	{4,8,19,32,36,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9e3436b0-58ff-43a4-8cb5-bdc985c4258d	lotto6	1636	2021-11-08	{1,12,24,26,30,36}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d38203ac-59b8-472c-b672-e28508015285	lotto6	1637	2021-11-11	{2,3,11,16,27,36}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
92da413e-e4d8-4d40-8cf1-3aeb80c7d104	lotto6	1638	2021-11-15	{21,25,26,35,39,40}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
64652163-6dfd-4463-b4e4-c7e1b4ef4465	lotto6	1639	2021-11-18	{5,9,13,20,26,32}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
75d008f7-a2bd-4b9b-a9bd-4936c9769711	lotto6	1640	2021-11-22	{8,9,19,21,27,30}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
326bfa31-8efa-4daf-b73d-e339383c196b	lotto6	1641	2021-11-25	{2,5,7,12,16,20}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6a6f0bfb-5ac2-4b34-abd5-6bff9e5034e6	lotto6	1642	2021-11-29	{5,15,16,24,34,39}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bb4effe7-ef9b-4008-a4e5-d9cbdef6d258	lotto6	1643	2021-12-02	{10,11,12,15,16,40}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
66b22632-2798-4424-83b1-e04d03317ac8	lotto6	1644	2021-12-06	{1,9,14,28,32,40}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dc831e86-c552-4420-b637-60ccbc5372e8	lotto6	1645	2021-12-09	{2,8,13,14,33,40}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a644f17b-d3f1-4957-8597-09fccee6c249	lotto6	1646	2021-12-13	{3,19,21,29,39,43}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
23c5fce3-3039-492f-8263-987df1b80633	lotto6	1647	2021-12-16	{3,8,14,15,19,35}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bc3c7f05-1f01-4465-8461-5186af077922	lotto6	1648	2021-12-20	{2,3,22,26,35,42}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f1524d90-5473-4910-b47a-5441f544591f	lotto6	1649	2021-12-23	{8,16,19,23,29,41}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
623cd3be-7bc9-4875-8964-9199c22191e2	lotto6	1650	2021-12-27	{1,3,15,33,39,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
01dddca0-b834-4b5b-890d-9ffa4908950e	lotto6	1651	2021-12-30	{7,12,15,21,27,32}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cc9f8d30-a09d-4888-85bb-8bb9fe65bb05	lotto6	1652	2022-01-06	{8,15,16,23,38,43}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e8ef021b-0239-40cc-9859-195822916e5c	lotto6	1653	2022-01-10	{2,7,10,12,29,36}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d7fdea33-a385-4fa9-9bdb-c11dfbd85640	lotto6	1654	2022-01-13	{9,10,14,21,22,33}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e9689132-b950-4ed3-9d36-a03cd0af7c25	lotto6	1655	2022-01-17	{21,23,31,38,42,43}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
816e2392-fb33-4c3e-acf4-90677cbc1e15	lotto6	1656	2022-01-20	{11,12,14,28,36,38}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
07576879-63eb-443a-b68c-10a8902b18f8	lotto6	1657	2022-01-24	{11,13,16,19,20,38}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bdd1ffb9-e3c2-4284-8350-1167ea50bd1d	lotto6	1658	2022-01-27	{10,11,19,29,30,36}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d5501be3-339b-434a-8079-333b56dfc238	lotto6	1659	2022-01-31	{4,10,23,25,37,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
394083a0-e12b-43c8-a94a-4e92c5ab5828	lotto6	1660	2022-02-03	{3,13,29,35,42,43}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3f5eab4d-736d-4fc6-8644-2bab5918389e	lotto6	1661	2022-02-07	{6,14,31,35,38,43}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0a38a755-f851-4b8a-80cb-f180fe80b745	lotto6	1662	2022-02-10	{4,17,18,25,26,27}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
65eb0280-ee98-461b-92af-1a0d2e920be7	lotto6	1663	2022-02-14	{1,6,19,21,27,39}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
09e7b49a-7136-45e6-9212-b26f5eb85e35	lotto6	1664	2022-02-17	{7,10,17,20,21,27}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1f934faa-a37c-48f0-99a6-eb27d65786b6	lotto6	1665	2022-02-21	{19,22,24,29,34,41}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e454a363-9629-47cc-9c93-3f92ddca1cae	lotto6	1666	2022-02-24	{14,16,26,37,41,43}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4ee19163-2d0f-43b0-9f67-7b47cd887be4	lotto6	1667	2022-02-28	{5,8,18,25,40,43}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
374bbd28-9771-42ea-ab8c-eee28b6cf0c5	lotto6	1668	2022-03-03	{5,16,21,24,31,34}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
efd7ba65-3d28-42fc-a77d-3b66612d6c72	lotto6	1669	2022-03-07	{2,4,13,14,22,29}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
04c2fc49-583b-4111-8716-9252fa5e98b1	lotto6	1670	2022-03-10	{1,16,20,23,32,37}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a896f233-2ec5-44f1-839b-5339bd8ddfb9	lotto6	1671	2022-03-14	{16,27,37,38,39,43}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cf58ee28-7b0c-4476-802e-c529b40e3f7f	lotto6	1672	2022-03-17	{6,17,22,27,37,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d5629441-7df2-4115-9bd5-5b6fec75fb5f	lotto6	1673	2022-03-21	{24,33,35,36,41,43}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fbe9e053-52a9-41f0-9b9a-133c2a7d4efb	lotto6	1674	2022-03-24	{14,19,25,29,33,43}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b07a27ee-f464-40ee-accd-972053c3f9b6	lotto6	1675	2022-03-28	{2,3,17,27,28,34}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
18c4e5ea-6a6e-467e-8567-b87855b77dff	lotto6	1676	2022-03-31	{5,13,21,27,31,36}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
181c9c6d-b701-4f65-9049-8f45996931ab	lotto6	1677	2022-04-04	{11,20,26,31,34,38}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e0bbd0b0-6b6d-43f7-a142-5c561b980c29	lotto6	1678	2022-04-07	{3,15,17,21,22,23}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f697f883-d253-4fae-aa7d-83190b337047	lotto6	1679	2022-04-11	{10,12,13,21,31,41}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
005e7eda-503c-493f-b1ac-f7fbd3f6de2f	lotto6	1680	2022-04-14	{4,19,29,32,35,42}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4ce77c67-74bf-4a80-a5e1-f4dd4e175305	lotto6	1681	2022-04-18	{1,7,11,13,15,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
793d39f2-a541-4608-b9aa-be65fbad6dc4	lotto6	1682	2022-04-21	{6,9,10,21,33,41}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e4660275-c6bd-4c43-b386-c5738a90f1ba	lotto6	1683	2022-04-25	{6,15,28,30,32,43}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4a9398d1-085c-44a7-b434-bce0bd063903	lotto6	1684	2022-04-28	{5,10,26,30,34,40}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e837222c-cb67-4dad-9a6b-85f273dc3e1a	lotto6	1685	2022-05-02	{1,26,27,28,33,37}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b750bed4-e893-414e-a8cd-96746260d67e	lotto6	1686	2022-05-05	{7,8,9,23,25,41}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
08d76541-fc15-4235-8b33-8befe788e6d0	lotto6	1687	2022-05-09	{20,21,23,26,29,35}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5f640ad7-21fc-443b-bd35-5de2c9ddb47f	lotto6	1688	2022-05-12	{2,4,10,24,34,42}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
99ee92c5-92d8-4a4f-91f5-ba6e86490546	lotto6	1689	2022-05-16	{4,7,21,22,34,42}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2b86c9c9-37aa-4026-8206-5685ac9050c3	lotto6	1690	2022-05-19	{8,16,21,23,29,37}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e402f0d1-102e-4082-9c78-d18ea3fc7641	lotto6	1691	2022-05-23	{13,16,18,29,33,41}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8b096df3-c790-45a2-8e8e-e63b3c0ae4d3	lotto6	1692	2022-05-26	{4,8,17,31,37,42}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8bf78785-05c4-4cd4-9bf2-52f959509c90	lotto6	1693	2022-05-30	{7,8,21,23,34,36}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f6c71346-eaf6-432f-9d6c-5fb2f60cb557	lotto6	1694	2022-06-02	{2,12,14,26,32,37}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cab2b63f-ad94-41fc-b004-a27050b2b2c6	lotto6	1695	2022-06-06	{3,8,14,18,28,37}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0d80de41-9d15-4fb7-9c39-1d1067d4d8bd	lotto6	1696	2022-06-09	{2,4,13,18,32,35}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4e23a28b-75f8-4bc7-95df-b15d8040b791	lotto6	1697	2022-06-13	{2,3,11,12,22,35}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
87f2d7e5-743e-4717-bf96-9e6204943ae5	lotto6	1698	2022-06-16	{6,16,18,33,42,43}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e4199bc2-cab5-4bfa-9736-b60451350af4	lotto6	1699	2022-06-20	{4,6,16,27,39,42}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8a1a0be9-1860-400f-90f2-b15bb52469ce	lotto6	1700	2022-06-23	{11,19,20,27,31,35}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1d6755e0-fb6c-407e-8fcf-4be5cb2bc158	lotto6	1701	2022-06-27	{5,8,27,30,33,39}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a3e73ec3-bc8d-4576-9415-04e563396886	lotto6	1702	2022-06-30	{2,6,7,18,27,38}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
694ae1a5-7045-4465-90f6-071b472d2614	lotto6	1703	2022-07-04	{14,22,23,30,33,38}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0aefe884-37c4-4f74-afc3-47cdb8a77528	lotto6	1704	2022-07-07	{1,5,18,26,39,40}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
77ec76d7-00c3-48b7-a645-874ab944bb5e	lotto6	1705	2022-07-11	{3,6,9,28,37,41}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b111adc8-dfb3-4872-b9a0-46805db81279	lotto6	1706	2022-07-14	{13,15,32,35,37,38}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e83439b5-3889-4333-936c-b7d5d1b57bb6	lotto6	1707	2022-07-18	{14,16,28,34,35,36}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
89fd0c83-0d89-498e-b734-e1b8e1a76ed2	lotto6	1708	2022-07-21	{1,20,29,35,40,41}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7ed5e6cb-9eb3-4106-a5e8-58aff0b565a6	lotto6	1709	2022-07-25	{3,4,7,20,22,41}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dbe0e464-47c9-4f0d-badb-ba99e67e4894	lotto6	1710	2022-07-28	{1,2,21,27,32,37}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
834826be-47c5-42d6-9ddb-05226cf27177	lotto6	1711	2022-08-01	{3,32,33,34,35,40}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8f059499-64e5-435f-ad32-efce08ce2582	lotto6	1712	2022-08-04	{1,5,15,24,25,28}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a2331dcc-278e-4ef0-8f82-ef494bf8192a	lotto6	1713	2022-08-08	{6,32,38,39,40,42}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b3fd0f67-1e2c-4f8c-b230-cc5c073e8472	lotto6	1714	2022-08-11	{11,15,20,26,33,42}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a761d324-6856-4ea7-adb5-f5d7fa1d035b	lotto6	1715	2022-08-15	{2,6,15,16,32,37}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c148ef80-a910-4b6b-a776-8937a072d561	lotto6	1716	2022-08-18	{2,26,27,32,38,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bff74159-2298-4dde-b75e-8ce522768f4e	lotto6	1717	2022-08-22	{15,21,23,24,33,36}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0de92528-d2ca-42fc-ac38-5071c511f66e	lotto6	1718	2022-08-25	{1,6,9,15,18,38}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1ddf489b-632c-4894-b1c8-5bfda86cb184	lotto6	1719	2022-08-29	{4,11,15,16,35,39}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
54b1f213-c2eb-40ae-8cf1-8f31fd0e6ed4	lotto6	1720	2022-09-01	{1,5,18,25,32,38}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d3597474-56c2-460a-b14a-12aad44f8b40	lotto6	1721	2022-09-05	{7,8,14,17,22,39}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8450167a-3f75-4a73-86a7-2134460ec2a7	lotto6	1722	2022-09-08	{2,5,30,33,36,42}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2964d657-547d-4fb3-84a3-48dedb8b4e41	lotto6	1723	2022-09-12	{6,10,15,16,30,38}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e3c82566-5947-4977-aac1-5c9a9546af37	lotto6	1724	2022-09-15	{6,9,24,26,33,37}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
72ee935d-49f5-473c-ac70-264d327d7ca3	lotto6	1725	2022-09-19	{2,10,16,17,20,28}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b0c80839-0008-429a-a709-e43e65c28482	lotto6	1726	2022-09-22	{9,14,16,21,27,43}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ed2d12b2-7e12-4584-9b3a-48535c97c816	lotto6	1727	2022-09-26	{3,13,16,22,33,42}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fc5a8f07-9238-407f-a12a-3b1fd141c044	lotto6	1728	2022-09-29	{4,8,14,18,26,38}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e8089947-c138-4937-a6f7-2dbf2ae523ec	lotto6	1729	2022-10-03	{11,15,24,25,28,31}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
43b8cebf-d4b7-491e-8481-b96db7f8d30c	lotto6	1730	2022-10-06	{4,8,16,21,22,26}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5db29ff4-ee93-4ff2-8903-8520766b75ac	lotto6	1731	2022-10-10	{3,7,19,21,32,35}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
713f643c-f1d1-41ce-bbde-7766f4b19279	lotto6	1732	2022-10-13	{3,18,19,34,38,42}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fc26cdd6-369b-45da-bb15-a606932b49f5	lotto6	1733	2022-10-17	{22,24,25,27,29,39}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
03251cd6-2bd6-4c93-9046-763038b8ce62	lotto6	1734	2022-10-20	{5,6,11,19,28,35}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
76e97970-3212-4388-a509-fe815f9adff1	lotto6	1735	2022-10-24	{1,21,24,33,40,41}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0c8262f4-e441-4079-ae88-1d2de7a3ae75	lotto6	1736	2022-10-27	{6,9,25,26,27,32}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a34906e9-199d-4416-9f30-dc4cc5689f54	lotto6	1737	2022-10-31	{12,14,22,24,29,33}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a3b26e85-5d53-4cef-ae9c-a12e78a32324	lotto6	1738	2022-11-03	{7,12,20,31,33,43}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f5f059e4-d236-47ba-b4fb-637cc5377937	lotto6	1739	2022-11-07	{1,7,12,36,37,39}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3df6f702-8a62-40a0-af9d-4c3097c702e7	lotto6	1740	2022-11-10	{14,21,24,27,31,38}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
285fc614-37c0-4d91-9858-f25e168ae9c4	lotto6	1741	2022-11-14	{4,14,17,19,22,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
adf1b2ad-de8d-49c6-b2bd-d76601c84515	lotto6	1742	2022-11-17	{16,20,22,29,33,40}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
cdc99de3-a6d1-40c6-ab73-7afc57077633	lotto6	1743	2022-11-21	{3,17,18,19,20,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
bcd5ddb8-6f98-4881-9b33-bcbbd38b2be2	lotto6	1744	2022-11-24	{1,8,21,25,26,35}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
308e1c43-7cbb-493a-b054-415dfa35d940	lotto6	1745	2022-11-28	{7,9,10,21,39,40}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6afaa55a-ef46-4011-bcab-6e2f7a1eed8a	lotto6	1746	2022-12-01	{3,11,14,22,27,32}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
53914663-6ade-4a25-8768-a87832c681b3	lotto6	1747	2022-12-05	{1,9,11,14,15,40}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7a7eca33-7c03-433b-8a56-5b030913fbc5	lotto6	1748	2022-12-08	{8,11,23,28,36,39}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
976e7d8a-43bc-4185-b520-03b9cf411b25	lotto6	1749	2022-12-12	{1,4,13,17,31,34}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f0beaf81-09d6-47f2-b432-f640963961ba	lotto6	1750	2022-12-15	{3,15,18,21,34,40}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
04e0457b-7602-4f87-990e-b9c2381d02e6	lotto6	1751	2022-12-19	{1,12,21,24,29,42}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
06297942-ab39-496a-bf54-a8d0309bfa06	lotto6	1752	2022-12-22	{2,5,15,20,22,36}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
73634cf3-c8b4-4a9c-b4da-6bba678bdc66	lotto6	1753	2022-12-26	{1,2,4,9,22,25}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e9eac186-c2a7-41cc-b639-4b4ca8e64684	lotto6	1754	2022-12-29	{3,6,7,19,35,39}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e702404d-e7c4-45de-a230-9c4de0dcf463	lotto6	1755	2023-01-05	{4,11,13,26,27,36}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
12afe3ba-b0b3-45e8-a370-4319f04d0d04	lotto6	1756	2023-01-09	{19,25,29,36,37,41}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0f8ea5c2-bffa-41e3-9d17-ba6f1bebd701	lotto6	1757	2023-01-12	{6,12,15,35,36,39}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0c324527-3259-4ff7-93a4-4305f3b654d8	lotto6	1758	2023-01-16	{7,14,28,32,42,43}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2559692f-0d9b-4384-a664-7eae5ceee8fb	lotto6	1759	2023-01-19	{1,10,25,27,28,33}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
75ff6c36-7282-41c3-9a18-e6e8aac46aaf	lotto6	1760	2023-01-23	{8,14,18,38,39,42}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8670215d-a230-40b1-82cf-b692cb46f7f5	lotto6	1761	2023-01-26	{5,7,13,21,23,30}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
93262ac8-b6c9-4406-b8de-dd955a7fb269	lotto6	1762	2023-01-30	{1,6,7,20,37,40}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4011094a-6f80-4c06-955e-a2c749b361ab	lotto6	1763	2023-02-02	{2,6,20,30,31,41}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2849d881-17c1-482b-bd63-b05d3612675d	lotto6	1764	2023-02-06	{16,21,26,31,39,42}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5881e4ba-6f6c-405c-a34a-f8b81036919f	lotto6	1765	2023-02-09	{1,10,15,19,20,32}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c08be57c-bcf3-4934-aa16-f271c46f3d9b	lotto6	1766	2023-02-13	{16,19,25,26,35,43}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
612d7cb2-2e2e-49af-9ed9-37a87a892054	lotto6	1767	2023-02-16	{7,15,17,21,32,35}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c27a7b71-338e-43f3-baff-3eb5295429aa	lotto6	1768	2023-02-20	{6,21,30,32,39,40}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
223a8f62-5fbc-4596-b605-ed4354ddb11f	lotto6	1769	2023-02-23	{4,11,15,19,28,32}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
058c854e-f865-451a-bbaf-4565ec4d75af	lotto6	1770	2023-02-27	{1,11,18,24,37,43}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7432c3a2-e80d-4277-9f8c-82323cd7de3e	lotto6	1771	2023-03-02	{3,6,12,16,31,42}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
09e9dfa6-15d5-4b0d-a6f1-e4a00af2a1cd	lotto6	1772	2023-03-06	{5,21,22,30,32,36}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
73fc2526-6add-414b-8dc8-101d15702e38	lotto6	1773	2023-03-09	{12,21,22,27,31,32}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3f4039e2-99e1-4b6c-ad2c-b53ceb1126ac	lotto6	1774	2023-03-13	{17,18,26,30,36,40}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b55e5a5c-6ac1-4750-968f-a00f3d16331b	lotto6	1775	2023-03-16	{4,5,9,26,27,29}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
694a8f2f-42cc-4c6a-bbd5-f161fa43f395	lotto6	1776	2023-03-20	{5,11,18,25,33,38}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e3e11be5-0961-4bfb-83c3-63f8975bf2d2	lotto6	1777	2023-03-23	{5,16,19,21,30,35}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6d16ab1c-285b-45b0-97fc-83b012388c87	lotto6	1778	2023-03-27	{9,19,24,25,26,39}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6bd3be62-3805-4130-8d0b-421a1e9581f0	lotto6	1779	2023-03-30	{11,13,20,33,35,40}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
590bb406-5af3-4dd9-94f4-4d12e07c10d1	lotto6	1780	2023-04-03	{1,5,19,26,35,37}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9f5f1e7a-7d5a-49ae-b657-d32dbee3e38c	lotto6	1781	2023-04-06	{10,18,32,39,41,42}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3e915bac-ca6e-4854-b848-d9ce46d68767	lotto6	1782	2023-04-10	{7,31,32,36,39,42}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f24230a4-cc03-49c1-9ce4-ac73de1fba19	lotto6	1783	2023-04-13	{5,14,19,23,30,42}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
94be3815-9870-44f4-ad8c-20d241f8a37b	lotto6	1784	2023-04-17	{3,19,30,32,36,40}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
eb5e0b11-e84e-4d53-9a14-aa18473a4ae5	lotto6	1785	2023-04-20	{4,11,24,35,37,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d9ddb5f7-1457-4937-bdb6-4405bcafc023	lotto6	1786	2023-04-24	{2,5,6,26,33,35}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9bac4d80-30fb-47c0-8aae-bec78b3c2f93	lotto6	1787	2023-04-27	{2,13,17,19,41,43}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ae916a58-6383-4944-a472-2536f23d1831	lotto6	1788	2023-05-01	{3,14,16,19,26,39}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
27555a3f-f55c-4b07-a107-0a5e01617c61	lotto6	1789	2023-05-04	{6,9,16,26,29,34}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6eee3694-edc9-4ce2-a48c-79e9c3ac63c5	lotto6	1790	2023-05-08	{6,14,18,22,29,30}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d6fa9853-9c5f-4df6-817f-362382d96de2	lotto6	1791	2023-05-11	{8,9,18,19,30,36}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8ff70bdf-ef6e-4ebe-86fe-2d0df64432ca	lotto6	1792	2023-05-15	{1,4,16,31,32,41}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
068fb502-072f-48d9-aa4a-1312e73e5e97	lotto6	1793	2023-05-18	{1,6,14,15,23,24}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
26770af4-2466-4cd6-a001-81fbab75a471	lotto6	1794	2023-05-22	{24,29,32,35,36,40}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f55e7a24-03fa-4f9a-b476-1039f77fbe03	lotto6	1795	2023-05-25	{26,30,31,35,41,43}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d6362cc3-1b91-478c-a8ef-df2bd52b0474	lotto6	1796	2023-05-29	{2,5,15,16,23,26}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7e4e28ce-02db-4af6-96bd-a4e07c6ec56d	lotto6	1797	2023-06-01	{15,23,26,34,41,43}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ada07684-7ef5-4111-a1d6-cff828043ab6	lotto6	1798	2023-06-05	{4,5,19,32,34,37}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c4a4940f-18e3-4280-bb5d-f19c3fe9dcb2	lotto6	1799	2023-06-08	{11,18,34,40,41,42}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
df5887f1-3ed2-454d-8ea1-0e5cab61e34b	lotto6	1800	2023-06-12	{6,12,13,15,17,41}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e5760771-e1c1-4f93-9b77-2a3d291da24d	lotto6	1801	2023-06-15	{18,25,26,37,39,43}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0384b401-6d3c-4aed-b9e6-6127aa681e6c	lotto6	1802	2023-06-19	{1,9,34,35,39,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a9abe95b-aa4f-40ab-9f8b-4df51206f91b	lotto6	1803	2023-06-22	{9,16,18,19,39,41}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7021704e-5eaa-4029-9a4b-16a09641049f	lotto6	1804	2023-06-26	{12,14,18,25,36,42}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
43490be0-8e8f-4cfa-b4df-af06513636f8	lotto6	1805	2023-06-29	{4,22,27,31,32,40}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0b9448cf-316f-491d-9cf0-9e3be712d8ae	lotto6	1806	2023-07-03	{11,30,35,38,40,43}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9af9a987-0f01-4477-8330-00160e39bcef	lotto6	1807	2023-07-06	{1,2,8,9,10,20}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a0864bd0-15f3-44b6-bb25-549441b5ac13	lotto6	1808	2023-07-10	{2,10,27,38,40,41}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
36881413-67a7-4fb1-aa8e-4d75a6735a25	lotto6	1809	2023-07-13	{2,5,10,22,24,42}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8f025d29-34a3-48dd-a7af-02cce0eb7020	lotto6	1810	2023-07-17	{4,17,26,30,31,43}	{25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4cc6f62f-7812-4b59-9618-272143e0fd77	lotto6	1811	2023-07-20	{2,4,6,13,20,38}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0bbd5745-279f-4a51-95d2-4e412bf82733	lotto6	1812	2023-07-24	{10,13,18,28,36,39}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
df686750-60b5-4da8-badf-b94f02cf3324	lotto6	1813	2023-07-27	{5,22,26,34,39,42}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
abded4ab-d747-4a7a-b7c9-cb7e90faf749	lotto6	1814	2023-07-31	{1,2,13,21,23,31}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a4ea6675-1897-47a3-be8b-b49594f1bbc2	lotto6	1815	2023-08-03	{3,8,10,25,26,29}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7249ddf4-233f-4bf3-95da-ad39a3242d63	lotto6	1816	2023-08-07	{2,21,25,34,35,40}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2487ae32-3723-4674-9073-64dea3768495	lotto6	1817	2023-08-10	{6,24,30,33,37,38}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d233c5c9-7d00-45dd-bf6a-96e50a917b21	lotto6	1818	2023-08-14	{2,11,23,25,34,36}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
83974484-7c40-4c2a-b533-1b03052a132f	lotto6	1819	2023-08-17	{5,8,18,20,24,34}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
51359c23-afee-4353-a3ab-eaa77c534522	lotto6	1820	2023-08-21	{5,10,30,35,36,41}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
aa99c95d-9812-4c3f-8ba7-387e188b5b04	lotto6	1821	2023-08-24	{9,11,12,14,27,38}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
91ede809-4907-48ce-a783-4c1e68603379	lotto6	1822	2023-08-28	{5,18,21,22,26,42}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9cca5070-d71c-4d67-8657-4de6c653b192	lotto6	1823	2023-08-31	{4,10,18,25,34,38}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
505fd759-5731-4468-8589-d8dcb29d9d00	lotto6	1824	2023-09-04	{6,7,13,18,25,43}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e81f931d-ca71-4118-a391-d0fe98934ff3	lotto6	1825	2023-09-07	{1,10,13,17,20,41}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5e57739c-bb76-49a8-8996-b6b3bfd42a40	lotto6	1826	2023-09-11	{7,14,18,19,22,25}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
900e21c0-af86-450d-8d48-c5347c4acd92	lotto6	1827	2023-09-14	{1,13,18,23,38,41}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d8b13eaa-5a67-4162-ae0e-8eb18a7eb5dc	lotto6	1828	2023-09-18	{1,6,9,16,18,22}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
41efcee8-fb9a-45b8-ad80-6fce8ceb7a63	lotto6	1829	2023-09-21	{12,15,16,17,28,42}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ae6de51d-195f-45cd-9144-a0c099dcfcab	lotto6	1830	2023-09-25	{4,10,23,29,31,36}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ae9e0035-14df-4e35-8916-ddb97cf1ba91	lotto6	1831	2023-09-28	{1,14,17,27,32,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6f184ec4-2f3d-48e3-a754-3e00b53ee680	lotto6	1832	2023-10-02	{2,7,20,25,35,40}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
375e4bd5-bce4-4af7-80dd-ad665f8f35b7	lotto6	1833	2023-10-05	{7,13,34,37,42,43}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
84d0e2fa-c6d9-4058-8240-4d76dadf61ac	lotto6	1834	2023-10-09	{14,21,30,38,40,42}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fc476d91-f878-4523-ba66-e5cb4dc3082b	lotto6	1835	2023-10-12	{11,20,23,24,31,33}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b22d5653-af12-4e80-bb05-e11592711c43	lotto6	1836	2023-10-16	{13,17,18,22,23,41}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7f9db8b5-363e-465b-a25d-36d9cc107dc5	lotto6	1837	2023-10-19	{16,17,27,34,38,42}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b944f90c-ce4c-4b2f-8908-28083683f76b	lotto6	1838	2023-10-23	{3,13,23,28,30,43}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ed7e1782-c9a9-4b7e-8501-275b6ca7da5e	lotto6	1839	2023-10-26	{2,5,26,32,34,40}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e9464525-2fdf-4cf3-988e-9e44519be0b5	lotto6	1840	2023-10-30	{4,9,15,21,26,33}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
34f5f8fa-cd6c-492f-9a5c-7c3c9e7418e0	lotto6	1841	2023-11-02	{8,11,15,31,33,38}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dbdce97e-5fb7-4580-ac5c-60384c25e1ed	lotto6	1842	2023-11-06	{4,6,9,24,26,29}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b77b3469-d02e-4e6f-ac49-325525b214ca	lotto6	1843	2023-11-09	{4,5,10,19,26,37}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
97b19c35-a817-486a-aaf1-3cdc9567f3d3	lotto6	1844	2023-11-13	{12,15,28,31,34,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
15323d14-009f-4880-8131-0d016b0e8735	lotto6	1845	2023-11-16	{10,22,25,30,31,39}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f091b85d-1ec4-42f7-ad75-3c175d12f2d7	lotto6	1846	2023-11-20	{6,8,15,16,33,37}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6a1fa17d-79f4-4775-b262-b7fb8da6fe63	lotto6	1847	2023-11-23	{18,22,25,35,36,39}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0ac493a0-ed91-4f45-aa6b-ca6d9f4452a0	lotto6	1848	2023-11-27	{3,23,26,27,31,35}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9e3e64b2-0090-4179-a721-e23d30a6275e	lotto6	1849	2023-11-30	{11,15,17,33,36,41}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c9ef7836-9382-4101-a2ba-cb9d8b8292ef	lotto6	1850	2023-12-04	{1,8,23,30,36,41}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3ac9c100-af1f-43be-b7d8-11f95e0f3bbf	lotto6	1851	2023-12-07	{8,9,10,16,17,39}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
83dd7369-df46-42b0-a68e-c0a471e30897	lotto6	1852	2023-12-11	{15,16,24,26,35,43}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0845afc1-2aa9-439d-932b-6dc7cb5418f2	lotto6	1853	2023-12-14	{11,13,24,26,28,34}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
60d9f489-5334-41f1-956c-b26b34600be3	lotto6	1854	2023-12-18	{7,8,12,25,30,32}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9dfc341a-d6d1-439f-938d-233c874da1e1	lotto6	1855	2023-12-21	{21,24,26,30,31,38}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3b299d2a-73e8-4b10-bce8-d056216e2d97	lotto6	1856	2023-12-25	{4,10,19,31,34,35}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9c97292e-33b2-4b7f-84ab-7d67e3adb8f8	lotto6	1857	2023-12-28	{11,16,20,23,38,41}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
030eaa9c-1ba9-4b5f-8e12-a54356b4b318	lotto6	1858	2024-01-04	{12,13,17,22,35,40}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
82dc633d-53f5-4bd6-8c8a-26e163546b9e	lotto6	1859	2024-01-08	{1,4,11,28,37,39}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
793c62ad-5523-498e-b27e-7314231c3914	lotto6	1860	2024-01-11	{8,15,20,21,31,34}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
392ce22b-3d1a-48ec-a7df-84709a51477c	lotto6	1861	2024-01-15	{2,12,13,27,39,40}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
aca4864f-0297-4736-aae4-b9c41e19b8b1	lotto6	1862	2024-01-18	{25,27,33,37,38,43}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6d85a692-cbd5-4bb2-be72-0fbe9f2bc078	lotto6	1863	2024-01-22	{15,20,24,37,38,39}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c4cfd528-fa1a-4a5c-82d3-6c7d3f87ae94	lotto6	1864	2024-01-25	{14,22,28,34,41,42}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
79bb7931-bdb3-4640-a527-876e38a881e4	lotto6	1865	2024-01-29	{3,5,18,21,26,36}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
87ac8351-9cd0-46b1-98b2-94658d80231e	lotto6	1866	2024-02-01	{8,19,21,29,38,40}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c8e1f933-cf28-4a99-858d-02ef75df6178	lotto6	1867	2024-02-05	{1,6,17,28,40,42}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
44b8bcd7-871b-401e-8933-61f98fe19a31	lotto6	1868	2024-02-08	{3,7,22,23,24,32}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
226f28fd-3b7e-447e-a075-85289cf633f2	lotto6	1869	2024-02-12	{7,8,16,28,36,37}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5bcb61e3-db3a-4866-b97a-b1118629552b	lotto6	1870	2024-02-15	{5,9,13,23,25,40}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c8986714-a1fd-4514-8984-09c423929ab2	lotto6	1871	2024-02-19	{7,13,22,24,38,42}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f148414b-db94-4ce1-8471-6e59eab11105	lotto6	1872	2024-02-22	{3,18,20,25,34,40}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c47b5696-dba4-409c-8422-3c5b9299f07e	lotto6	1873	2024-02-26	{6,15,26,33,39,41}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
091b2654-bdf0-4c35-bb2f-9cbc68438667	lotto6	1874	2024-02-29	{13,31,33,36,41,43}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
36a6f31c-0779-4943-abe4-c4d9727a467c	lotto6	1875	2024-03-04	{11,15,16,24,38,39}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
52321242-9ce5-49ef-97f0-3aa6a15d7392	lotto6	1876	2024-03-07	{4,7,17,31,38,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e74cc3ff-9221-4e5a-8d73-7bc1af1f1698	lotto6	1877	2024-03-11	{1,11,13,16,21,37}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7f78e4bf-cf8b-4cf1-802b-b1ca9265508c	lotto6	1878	2024-03-14	{6,8,12,18,32,38}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0b8def8f-78fa-4cf3-9828-a9f81b4ccf41	lotto6	1879	2024-03-18	{1,8,14,27,29,37}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
15be5cd6-a626-4adf-86b9-642468b75fac	lotto6	1880	2024-03-21	{9,14,21,31,33,43}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ca7fdcfe-ca2f-4dc0-88df-f63ace3722ef	lotto6	1881	2024-03-25	{2,9,22,31,33,35}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
24ec2a16-b9a6-4efa-9286-e6e46d74727a	lotto6	1882	2024-03-28	{3,6,11,25,36,43}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
423135cf-9e39-45d9-adb7-1ee6736170e5	lotto6	1883	2024-04-01	{3,11,24,25,28,32}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6f4ad4d8-cb1c-4855-b142-d94a3b1a44f1	lotto6	1884	2024-04-04	{20,25,29,36,38,42}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
726f88c5-e5eb-45bc-ab80-b2e423807111	lotto6	1885	2024-04-08	{2,6,7,16,17,41}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3df3ffd7-c5e3-450b-b275-4d69667bfaa8	lotto6	1886	2024-04-11	{1,6,19,25,33,39}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
31671b0d-5599-4bbd-aea9-aac139f2ca8c	lotto6	1887	2024-04-15	{5,7,15,18,36,37}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1af9a5be-c932-4f63-833b-7311e032920f	lotto6	1888	2024-04-18	{4,5,6,28,29,39}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
76b7ad00-11e4-4473-8b11-419e238607be	lotto6	1889	2024-04-22	{7,15,21,27,28,32}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6475e601-6b43-4289-83ab-a19b4174e9c1	lotto6	1890	2024-04-25	{17,21,29,34,41,42}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f999b7f5-3dab-4599-861b-c699e3d3f088	lotto6	1891	2024-04-29	{2,16,23,38,40,43}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8db20fdb-7ce7-4fb0-b2b1-3c8f74d4ddf5	lotto6	1892	2024-05-02	{7,8,9,19,22,38}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f5b17705-9850-4b89-90a3-89fad07ed533	lotto6	1893	2024-05-06	{25,31,33,35,37,42}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
14ab80e9-5006-48a4-b726-6c37df966dbf	lotto6	1894	2024-05-09	{19,29,36,37,41,42}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0a3dd61c-b731-4996-8ca9-2a88619a24be	lotto6	1895	2024-05-13	{6,18,29,33,35,40}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a39ed494-0f6e-4070-aa34-5f0a67218061	lotto6	1896	2024-05-16	{5,12,15,16,28,40}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
215ebd2e-6ea8-4c6b-ac23-e310ec8201b8	lotto6	1897	2024-05-20	{7,23,27,30,34,36}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c5167072-d816-401f-ad2b-b65b6aa14ea0	lotto6	1898	2024-05-23	{5,19,23,26,31,42}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4eb76170-2999-4ae0-968a-e776a1e9f6f5	lotto6	1899	2024-05-27	{2,4,9,19,33,36}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
248a995c-d497-44d1-9bd7-8db1423b5f5e	lotto6	1900	2024-05-30	{3,9,29,30,39,42}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
63208833-b215-4b8f-9a36-79a7b0fb8a32	lotto6	1901	2024-06-03	{14,15,26,28,33,37}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0af663bb-b5c8-44e3-ab16-e5fa3fbeaff2	lotto6	1902	2024-06-06	{4,7,15,18,35,40}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f9d8caed-ac11-4e59-ad3b-ac6145770498	lotto6	1903	2024-06-10	{18,19,23,25,27,32}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
866759bb-33a7-42e4-8b69-0d841f25a984	lotto6	1904	2024-06-13	{14,21,23,24,28,36}	{7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
25641cd8-75ed-45a2-91ec-6a14c51bcf61	lotto6	1905	2024-06-17	{4,5,17,20,29,30}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
01781d03-2cf7-4a0c-b220-020473cefb30	lotto6	1906	2024-06-20	{1,8,21,22,30,42}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6cec9cfa-71f9-42d5-892d-9976109b976e	lotto6	1907	2024-06-24	{10,14,21,23,24,40}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9e6c91ca-188e-44a6-b2eb-4ead69461496	lotto6	1908	2024-06-27	{3,9,21,25,42,43}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8823e396-42d1-44b7-94a4-886d3261b2cd	lotto6	1909	2024-07-01	{3,5,7,8,22,27}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
65f25c2e-98c6-4d35-8a9a-a4fdbf9e2b11	lotto6	1910	2024-07-04	{2,8,24,29,30,31}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d1ff11cc-d137-4876-ab09-9d08d4691895	lotto6	1911	2024-07-08	{4,8,9,14,16,41}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3025b603-98a2-4f5e-88bb-537e79c52b7b	lotto6	1912	2024-07-11	{1,11,24,29,33,34}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
72fb60a8-8b2a-4f84-9c28-8088a75fc659	lotto6	1913	2024-07-15	{2,5,22,23,29,33}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3ddeaaa3-4535-4c15-aafb-c22d68920a48	lotto6	1914	2024-07-18	{4,10,22,24,36,38}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e1663581-a84e-420f-8fed-0b063908f1bf	lotto6	1915	2024-07-22	{4,10,14,19,24,40}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3d0e68e2-3899-4399-92b0-ea74eaecb760	lotto6	1916	2024-07-25	{5,13,18,23,30,39}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e208b5b5-ed4f-428d-9d3f-39ba98b206a3	lotto6	1917	2024-07-29	{3,12,14,29,30,33}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d520ece7-8337-4a25-87ba-4a01566137ed	lotto6	1918	2024-08-01	{3,4,5,6,18,20}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a111815c-e262-4db3-8c93-22c9d16c547c	lotto6	1919	2024-08-05	{5,17,19,21,38,41}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3f0ed7c5-e900-4772-abc9-4fd6bec1189b	lotto6	1920	2024-08-08	{6,10,22,23,31,36}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4066723f-2ff6-4ce6-82a4-3d55457ab10c	lotto6	1921	2024-08-12	{1,2,13,25,33,41}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
520e6e7d-dd28-48cc-aea5-55974ada0b17	lotto6	1922	2024-08-15	{3,11,22,31,33,35}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
78e325bd-b655-4f24-b78a-4fed06fabaaa	lotto6	1923	2024-08-19	{6,7,18,30,34,37}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2614468a-0c43-47a4-92a7-cdb7e7825f96	lotto6	1924	2024-08-22	{7,16,18,25,26,27}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2da23ccb-34bf-42f0-9799-ddf2dedf6128	lotto6	1925	2024-08-26	{5,9,11,18,34,37}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
02f9b855-5c85-4a56-abf5-0d0d840d88c3	lotto6	1926	2024-08-29	{10,13,18,24,34,37}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
50b2540c-a60f-4e36-be4f-d1fde66b879d	lotto6	1927	2024-09-02	{2,11,18,26,32,36}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7ec3d5f5-a8c1-44cd-8f91-497ca096aa92	lotto6	1928	2024-09-05	{2,18,20,24,26,29}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5b21625a-24ac-4d12-bc5e-3e431097bf02	lotto6	1929	2024-09-09	{7,10,12,20,40,43}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
760bc2d2-377a-4f93-9ae4-198f8c51e636	lotto6	1930	2024-09-12	{5,10,19,23,29,37}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
52a4c754-458f-4a9f-abfb-6cdadb05cfb8	lotto6	1931	2024-09-16	{9,23,27,30,33,41}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
199651dd-ff2e-4a95-92f6-afb9de0fd36e	lotto6	1932	2024-09-19	{1,5,16,20,24,31}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
dd68b7ca-d3d7-4382-9d6a-4b9cf9db90b2	lotto6	1933	2024-09-23	{3,7,9,10,12,30}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3a34ee13-824b-4d5c-9449-433fb79ab19e	lotto6	1934	2024-09-26	{6,13,16,20,27,41}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d147a22a-ffb6-46bc-9bdb-255bc08f5350	lotto6	1935	2024-09-30	{3,8,12,14,17,40}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
94c2a970-10cb-4010-9777-5ba991683d70	lotto6	1936	2024-10-03	{1,6,19,29,33,35}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3cbe28df-d237-432e-ab61-6f2cc6154d01	lotto6	1937	2024-10-07	{1,9,26,28,31,38}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e992bdfc-b99b-411b-8be0-f7a600e8edf7	lotto6	1938	2024-10-10	{5,9,14,32,39,41}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0ad94d10-38cd-4886-94f4-3259c8199b20	lotto6	1939	2024-10-14	{10,22,26,27,29,37}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
29b699dc-b495-4211-acdc-20550ebb8e1d	lotto6	1940	2024-10-17	{2,14,15,25,26,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
800c6606-58c4-4a15-85be-eb5847cbb183	lotto6	1941	2024-10-21	{2,12,13,21,23,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
18f702cc-07d6-440d-a98a-8517665da9c4	lotto6	1942	2024-10-24	{1,16,18,26,27,35}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c57b53dd-d2ee-429a-862f-315024dd2397	lotto6	1943	2024-10-28	{10,11,17,25,34,38}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9b795511-28b6-421b-b366-ea570b10d288	lotto6	1944	2024-10-31	{6,11,21,33,39,42}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a1187db1-2eca-44f9-acde-93371fd8e2c5	lotto6	1945	2024-11-04	{1,2,4,14,27,43}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
44b1bdc8-7b54-4b17-a7f7-69f258d11d30	lotto6	1946	2024-11-07	{8,9,11,27,36,38}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
50cfa8b1-6359-4fa3-b40e-a8127bc0abaf	lotto6	1947	2024-11-11	{10,24,30,36,37,41}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
50afd747-b9e4-4c97-81aa-41dfc52d8d31	lotto6	1948	2024-11-14	{18,29,30,38,39,43}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
182d402f-f0b1-477c-aea0-bbc2e755f11e	lotto6	1949	2024-11-18	{12,13,17,28,37,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
2078ae00-bece-48fa-a9e2-3ba9d57cb6dd	lotto6	1950	2024-11-21	{9,20,26,28,30,42}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fadddc7e-0b54-49e8-8207-2b8cefb8f0ad	lotto6	1951	2024-11-25	{1,3,6,23,28,35}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
879105fe-b6d9-4f74-87b9-99bd376d818d	lotto6	1952	2024-11-28	{24,25,31,32,34,40}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f2bb4b92-84ce-4696-9441-c89a133880ec	lotto6	1953	2024-12-02	{19,23,29,33,36,40}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e59ccd0c-3c85-48e5-8b8f-a76c9c3b86c2	lotto6	1954	2024-12-05	{2,10,15,25,35,37}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
01fef016-c6cd-46b3-bf20-600e1f511195	lotto6	1955	2024-12-09	{11,19,26,28,29,36}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
8086b922-c9e5-4d5d-be8b-63365f5dcbd9	lotto6	1956	2024-12-12	{2,19,21,24,35,42}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e62640f7-1e85-4594-87f3-a22698d30db1	lotto6	1957	2024-12-16	{3,4,5,13,34,42}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a0fcb98f-5568-4cf1-a8cf-2d5c5da057f3	lotto6	1958	2024-12-19	{1,15,16,20,21,25}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
abd34e75-2d30-4194-8f43-550c7aa9456a	lotto6	1959	2024-12-23	{19,20,36,40,41,43}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
29a6dded-6bf9-46c1-bde6-727b77188c99	lotto6	1960	2024-12-26	{10,22,27,28,31,32}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
60e766d7-9709-40e3-ac0a-c5408603a589	lotto6	1961	2024-12-30	{11,12,27,28,38,43}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
89264977-2c51-4689-aebb-3e743735a38c	lotto6	1962	2025-01-06	{4,8,19,22,32,37}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d26907ee-59c8-4668-89ac-a6cc818225d6	lotto6	1963	2025-01-09	{3,4,20,29,35,38}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
b91462f7-6ea6-4d36-9562-c2b4d2bd2334	lotto6	1964	2025-01-13	{2,5,28,33,35,36}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
147fa425-b936-4eee-a001-33bc0956a593	lotto6	1965	2025-01-16	{17,18,20,23,33,43}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
3bb9b69f-58ce-4142-a0a6-ad996b92d4f6	lotto6	1966	2025-01-20	{4,12,25,29,34,36}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6cd9e5c0-5a88-4a6a-b1a6-1ffe18e72616	lotto6	1967	2025-01-23	{3,4,22,26,29,35}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6ac37b5d-e319-40d7-9fd5-b3fcdb4d3708	lotto6	1968	2025-01-27	{6,13,15,22,35,41}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fa1775bb-cd7a-4f58-a86a-ab9321843028	lotto6	1969	2025-01-30	{3,7,12,13,35,38}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
ac8245da-8a17-4b1c-ba6f-70f5b25e3016	lotto6	1970	2025-02-03	{11,26,27,31,36,37}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
29c6fe9e-d8b9-4b1b-a6a8-d3790926120e	lotto6	1971	2025-02-06	{2,6,9,26,32,36}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
97abb7a9-ac6b-4c24-bac4-35235aba56cb	lotto6	1972	2025-02-10	{3,14,27,28,32,36}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9bf11cc6-c5cd-4c54-a9c5-1560c7068213	lotto6	1973	2025-02-13	{7,10,14,27,28,32}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e737c7de-b50e-4670-a077-4f84c1099b92	lotto6	1974	2025-02-17	{2,6,13,21,24,30}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7217ed46-e025-4a57-bfee-b64dcb669e16	lotto6	1975	2025-02-20	{11,13,15,20,35,42}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a9ea17b1-8ac8-4c30-a043-98ca3ce3763a	lotto6	1976	2025-02-24	{4,6,22,30,33,36}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
d4f936f7-6589-423d-99ad-6631c338f8e5	lotto6	1977	2025-02-27	{4,14,20,28,29,34}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
69dd8fd8-4917-4063-96e3-fd128219f93e	lotto6	1978	2025-03-03	{23,25,26,30,34,35}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
026d43f5-e2ba-4ce5-8449-63d3af35f7b6	lotto6	1979	2025-03-06	{15,18,19,21,37,40}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
4fd30621-0350-491e-b5b5-2691af55d0b3	lotto6	1980	2025-03-10	{1,2,13,19,35,41}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
f46d52a9-5e8c-4861-b18b-a09b732f6813	lotto6	1981	2025-03-13	{5,10,15,17,29,41}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
0a3a08d2-d04f-427d-8374-c5f427c21681	lotto6	1982	2025-03-17	{20,21,23,28,32,34}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7c7740ea-20b3-4ccf-a336-3fd08f1e2634	lotto6	1983	2025-03-20	{3,18,31,36,37,40}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
eca1ccda-26ad-4ea8-aefe-6db0bdee0d0b	lotto6	1984	2025-03-24	{4,19,28,29,34,40}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c9ba5bfd-c221-4fca-b829-bca22c97b169	lotto6	1985	2025-03-27	{1,30,36,37,41,43}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9b187132-7708-4085-aef8-efd1a91b6706	lotto6	1986	2025-03-31	{14,20,29,31,41,42}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
142b7333-f144-4d1f-9513-3d4fb7beffc5	lotto6	1987	2025-04-03	{8,12,25,28,32,42}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
fb63658a-01b2-440f-9b8c-f4224d84b208	lotto6	1988	2025-04-07	{6,20,23,24,33,35}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
6a0d4d79-766c-40d5-b219-655105602f61	lotto6	1989	2025-04-10	{15,17,23,29,35,43}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
c05648d7-84a3-4caf-9a86-7340489cce30	lotto6	1990	2025-04-14	{6,9,15,19,24,40}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
a0281192-9c44-4a27-bf8d-3487cdaecea8	lotto6	1991	2025-04-17	{1,5,12,16,17,40}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
1e59056c-e4d8-4868-9400-2555ee97579d	lotto6	1992	2025-04-21	{9,11,18,21,27,34}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7a849b4a-95ef-441c-a52a-4fb5f5c93784	lotto6	1993	2025-04-24	{7,12,13,35,37,42}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
13f55729-b79d-408a-8f3a-c1b21134aa41	lotto6	1994	2025-04-28	{10,11,13,16,24,26}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
327b115c-0b02-4a15-9163-8c077d296498	lotto6	1995	2025-05-01	{2,4,8,26,27,37}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
9fef08de-dcc8-4297-8b86-df6a1177dced	lotto6	1996	2025-05-05	{6,17,26,28,33,34}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
e6ebe4c8-bffc-4beb-903a-0e3a34ed65d6	lotto6	1997	2025-05-08	{5,16,17,28,36,40}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
5fa48e01-d7e3-413e-81e3-42c019fb77d6	lotto6	1998	2025-05-12	{1,4,6,9,20,43}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
7da44b5c-ef38-48b2-ba08-5dc89697ae5e	lotto6	1999	2025-05-15	{17,31,34,35,36,38}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
68d2c149-a88a-4f57-b1f0-ff8e283780f7	lotto6	2000	2025-05-19	{1,2,16,21,25,35}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.561353+00
eb995bdc-3d87-4f88-b6db-559799b28b5d	lotto6	2007	2025-06-12	{6,18,23,24,30,35}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
37d0704f-6943-4e04-b2bd-66801823ccb9	lotto6	2008	2025-06-16	{5,8,9,17,22,36}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fb9a0127-11bb-4e42-a7e1-d4be29e89ada	lotto6	2009	2025-06-19	{8,17,20,35,36,40}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bc360c2d-2b56-45b4-a653-ee237f1d784e	lotto6	2010	2025-06-23	{9,15,24,29,31,40}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d82939b7-4c71-40db-9733-835841787e59	lotto6	2011	2025-06-26	{12,14,18,24,30,42}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
70950c62-2aec-4db6-a879-edf79bd4f410	lotto6	2012	2025-06-30	{1,14,20,36,38,41}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
047a4259-8023-44f3-b101-5cdd494fab69	lotto6	2013	2025-07-03	{7,12,30,31,39,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
316dcc51-1d72-4d9e-ac92-6e66dc3ed4c6	lotto6	2014	2025-07-07	{7,11,21,24,29,34}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
55aa3b5d-533a-430e-9a00-5a8a0295800f	lotto6	2015	2025-07-10	{6,8,13,16,20,23}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
737807b4-d07e-478b-96d5-6d3e8c04f41b	lotto6	2016	2025-07-14	{10,13,27,31,40,42}	{1}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
50d7b39e-a922-4532-999c-6bdd5641240a	lotto6	2017	2025-07-17	{2,4,11,22,24,35}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
32de0c72-fff8-4583-b0b0-2cda8f09089a	lotto6	2018	2025-07-21	{1,2,14,21,22,33}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
77816dab-970d-445c-8497-46c250f6ebec	lotto6	2019	2025-07-24	{7,13,14,21,39,42}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8d55fb78-b4e5-4e13-b4dc-eeddb9963a03	lotto6	2020	2025-07-28	{5,21,23,28,38,39}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f70d70de-b5cc-474d-a6c7-05423be19afb	lotto6	2021	2025-07-31	{2,17,22,29,30,43}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
065eaa89-ea17-4c2c-b018-7d40e4cdea83	lotto6	2022	2025-08-04	{2,3,18,26,31,33}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ab2f1583-6832-4842-a201-9c1229d771d9	lotto6	2023	2025-08-07	{1,20,28,29,31,43}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
705cf59f-9255-46f8-a0ad-6ad234788e4f	lotto6	2024	2025-08-11	{10,13,16,29,34,42}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a4701be4-f654-4d66-8e3c-6686d2692ca7	lotto6	2025	2025-08-14	{12,18,26,28,41,43}	{35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d674f077-4831-4470-9ece-45b296c3c5d1	lotto6	2026	2025-08-18	{2,5,8,11,20,26}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5c29094f-b838-4359-8d86-472c5c6d9abf	lotto6	2027	2025-08-21	{5,12,18,23,34,39}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a68a3a8d-e858-481b-aa0a-4db4fdeab0ec	lotto6	2028	2025-08-25	{6,10,12,19,21,42}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
14fc018f-f123-4348-9de7-ea0153174998	lotto6	2029	2025-08-28	{7,21,31,36,40,43}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9334ae91-d00f-4584-9aea-ab2317e002c2	lotto6	2030	2025-09-01	{3,7,28,29,32,36}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5a33bd29-ed24-4e83-a171-a4d12e1221c9	lotto6	2031	2025-09-04	{2,3,16,20,23,29}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2fec4681-6e76-4984-9a5a-d7116d5722d1	lotto6	2032	2025-09-08	{8,15,27,33,37,39}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c95803cb-8350-41b9-9322-8a2bf6410ae6	lotto6	2033	2025-09-11	{5,16,21,22,33,35}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3b3aa6b5-a286-4365-9e06-5859aa2a8898	lotto6	2034	2025-09-15	{2,13,22,25,35,37}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d715aa0c-845e-42aa-ad7b-73b6b4694398	lotto6	2035	2025-09-18	{5,10,12,17,21,35}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
464f2239-d80a-4941-a1e1-964862d6524b	lotto6	2036	2025-09-22	{7,10,17,26,35,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b49f89b0-18dc-41b2-aff3-8ca133496dfb	lotto6	2037	2025-09-25	{7,12,20,23,27,29}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b382b45b-bcc0-4a3a-a185-f87a711171be	lotto6	2038	2025-09-29	{5,31,37,39,41,42}	{33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
70efc55b-68fd-4a4c-bfdb-70e4b081897a	lotto6	2039	2025-10-02	{2,15,25,27,38,42}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a987e7c0-1b75-4050-8515-28eb24f8acac	lotto6	2040	2025-10-06	{7,12,14,15,24,30}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
710d7118-8e01-49e4-8837-603fb3d7a206	lotto6	2041	2025-10-09	{4,19,22,24,32,38}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
84360ee3-be3e-4c8b-8e15-3f82e165629b	lotto6	2042	2025-10-13	{9,14,29,38,41,43}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
48f33b09-40bf-42b1-9a16-122665df058b	lotto6	2043	2025-10-16	{11,19,22,34,40,42}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f1b80980-a5d1-40a7-8ff6-c2edd795da37	lotto6	2044	2025-10-20	{1,6,11,26,33,40}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d9c12e83-820c-4217-b369-f47446ecc057	lotto6	2045	2025-10-23	{1,4,7,12,16,28}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
82a89a07-e8c1-4e50-8faa-331b2c6505d1	lotto6	2046	2025-10-27	{2,5,10,22,25,38}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
14974711-bb6a-4209-b4f3-dcbf4a68ac01	lotto6	2047	2025-10-30	{10,11,16,19,37,39}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7fa4ebda-ad75-4b3b-adf6-b6e56028ee8b	lotto6	2048	2025-11-03	{8,13,18,32,37,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9eea6646-007f-431d-8018-882eac778c75	lotto6	2049	2025-11-06	{10,24,25,39,40,42}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5e957055-befd-440d-836e-25a13ad5e732	lotto6	2050	2025-11-10	{6,11,15,21,25,32}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
45cc5e9d-06f9-401d-b000-27d18bc5755b	lotto6	2051	2025-11-13	{3,15,27,28,31,39}	{20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a305ec50-a37f-4b89-945f-f2755f0d37bc	lotto6	2052	2025-11-17	{1,3,18,25,30,34}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
82e4f5b0-8259-4704-bbab-8229752b5955	lotto6	2053	2025-11-20	{20,28,31,35,37,41}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
289ca9e1-f82c-481d-86a9-4b82be48dd29	lotto6	2054	2025-11-24	{1,14,27,30,33,37}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c72654bc-083e-4e69-b62e-8bec480532e9	lotto6	2055	2025-11-27	{11,12,14,17,21,26}	{2}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4687fd4b-698e-4544-ae88-131474fae611	lotto6	2056	2025-12-01	{3,7,15,17,19,30}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f9998149-9d10-4617-a46b-d4db7c25ac7d	lotto6	2057	2025-12-04	{5,7,21,22,38,41}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c9c354ef-9b29-444a-9662-ea1b51b38aa1	lotto6	2058	2025-12-08	{9,12,14,16,19,42}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a57d3eaa-f5ab-403e-9301-4b0ef6b2394b	lotto6	2059	2025-12-11	{2,13,26,28,38,43}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1b17b956-ebf2-44e8-b83e-f6a6ff0dcbc4	lotto6	2060	2025-12-15	{8,16,22,40,41,42}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
cc4ff6c9-cf9f-4bb5-8c35-b16c2957966e	lotto6	2061	2025-12-18	{5,6,13,21,33,34}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a1d49129-24e8-4013-aadf-26bc1d0bb2cc	lotto6	2062	2025-12-22	{1,9,18,24,35,42}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9655dcde-bf7e-4b6f-90b3-217c83f7efc8	lotto6	2063	2025-12-25	{4,28,29,30,38,42}	{15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d246dc86-5ecc-430c-80a7-3fb959c41508	lotto6	2064	2025-12-29	{2,7,24,37,39,41}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d56f3305-3b41-47c0-93e9-0cc0187fa931	lotto6	2065	2026-01-05	{6,18,21,31,37,40}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
911eb499-aa34-4b59-a98e-602102735a96	lotto6	2066	2026-01-08	{8,28,30,32,37,38}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
cf68a7f3-ecfe-4116-a641-37c89d4f6657	lotto6	2067	2026-01-12	{3,4,12,15,32,42}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
de6fb70f-f684-4e3a-ba8a-e75fe6eaec4a	lotto6	2068	2026-01-15	{2,10,13,14,29,33}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4c934ae7-9d77-4e4b-add5-2aeb0fa473a4	lotto6	2069	2026-01-19	{6,17,23,27,33,35}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dce11b44-6971-4239-9463-f5130f77c7c2	lotto6	2070	2026-01-22	{6,10,25,30,34,36}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
40d8b8c6-78c7-476b-91c9-55e096319454	lotto6	2071	2026-01-26	{15,24,29,32,33,35}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
807d0eb7-90ba-460f-a590-88c53cf867e8	lotto6	2072	2026-01-29	{8,18,24,36,40,42}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bfcf5de1-6dee-4237-86b9-459384c5a6d1	lotto6	2073	2026-02-02	{2,12,14,24,26,29}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3d053cc1-6cff-4d52-8cdb-e0f5ec5b0573	lotto6	2074	2026-02-05	{5,6,16,26,27,36}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a6ddd810-bda7-45e0-9592-828b31c34c5b	lotto6	2075	2026-02-09	{7,10,14,16,35,37}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8cc6c030-8640-4d88-ac0f-2dc97aa87150	lotto6	2076	2026-02-12	{1,9,20,22,28,41}	{30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0b99f588-6666-46a9-bb1b-a6f01550df01	lotto6	2077	2026-02-16	{17,18,23,24,26,43}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
702703b6-3924-41cb-ab9a-17fd5d1ceda9	lotto6	2078	2026-02-19	{1,10,20,24,30,35}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6811b7c9-f6b3-4455-bb81-b1a170a6c47b	lotto6	2079	2026-02-23	{5,11,15,17,24,39}	{31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
29ee2373-d079-41b4-a72e-366ddc694227	lotto6	2080	2026-02-26	{6,12,30,36,37,38}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c2d16c15-64e0-481d-aa89-72972fccf3e9	lotto6	2081	2026-03-02	{14,31,32,37,41,42}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7632cb39-2256-4e1c-ac5e-1771764b3a20	lotto6	2082	2026-03-05	{5,11,14,19,25,40}	{17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9ddd748d-03b7-4fc2-bd97-6492b9ef512c	lotto6	2083	2026-03-09	{8,10,13,17,26,29}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2b9aae4b-d7be-4c69-bca3-8f241341f759	lotto6	2084	2026-03-12	{8,17,18,19,30,39}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e482baad-9261-4b12-bd26-b82b263c5bae	lotto6	2085	2026-03-16	{6,8,13,26,35,43}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ba5f5712-f2fc-4846-9f91-2c401ffd6935	lotto6	2086	2026-03-19	{4,11,19,28,39,40}	{6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
06c23bf7-4726-42ae-b09b-6dec4533dee8	lotto6	2087	2026-03-23	{7,10,15,18,26,39}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
cbb91bd7-87d3-43a1-abd2-de730de71e0d	lotto6	2088	2026-03-26	{8,16,18,27,37,39}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3d10f75f-b154-45b6-a34b-329ba459685c	lotto6	2089	2026-03-30	{9,16,18,32,37,43}	{13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
86723851-c09c-4ecf-906a-b464e844f0c0	lotto6	2090	2026-04-02	{2,3,6,9,24,36}	{5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d2c10a73-efcb-4f60-afe5-ca6f49746d5b	lotto6	2091	2026-04-06	{6,16,21,25,28,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ccdc11f2-c228-4d48-bd76-b6e6d2fd3c37	lotto6	2092	2026-04-09	{8,13,27,36,37,43}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a3c91123-c588-418b-b4df-abb09799c8d4	lotto6	2093	2026-04-13	{2,10,21,26,29,38}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
eb13a11e-f462-44f7-a139-05c737373b3b	lotto6	2094	2026-04-16	{3,4,7,11,24,30}	{16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7dc5fbfd-aec7-4120-a64c-d8579c244e03	lotto6	2095	2026-04-20	{13,20,22,23,28,30}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2e676e88-1c25-4265-870a-415c23c6620d	lotto6	2096	2026-04-23	{8,15,18,21,33,43}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
07cf4b1e-1423-4c3a-a584-ad54af685dfc	lotto6	2097	2026-04-27	{3,20,24,27,34,42}	{37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
390b8bc5-0216-4f6f-a694-9e49e79b6a27	lotto6	2098	2026-04-30	{1,6,15,18,19,42}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8796914b-9181-4a53-b678-7bcfacd9a7c7	lotto6	2099	2026-05-04	{19,21,34,36,39,42}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0a4f57fa-a72d-40c2-8032-7887a0672459	lotto6	2100	2026-05-07	{8,17,24,32,35,41}	{28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
04706898-8502-41c6-9359-7275c722b2e8	lotto6	2101	2026-05-11	{1,17,29,33,40,42}	{21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
75e89983-49cd-45b8-b5d8-f982e59d7b9e	lotto6	2102	2026-05-14	{18,21,25,28,30,43}	{8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a4ad4d6a-8302-48c3-9680-6666b8a81cbf	lotto6	2103	2026-05-18	{1,2,4,5,8,38}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
27597838-44c3-409c-b841-94e81ea97a46	lotto6	2104	2026-05-21	{18,19,21,25,28,34}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
33604837-9e60-4254-b759-82b876b912ff	lotto6	2105	2026-05-25	{5,26,28,30,36,40}	{32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1e2ac106-310c-43e8-93cd-ca313e2c290b	lotto6	2106	2026-05-28	{1,6,17,27,34,43}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fb75c873-b3af-4465-b639-4f18e1261006	lotto6	2107	2026-06-01	{5,8,27,32,36,39}	{38}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b54bd16a-d171-4071-92ce-27cbf84e4034	lotto6	2108	2026-06-04	{2,5,10,15,28,43}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e865def1-632a-4c6b-9811-dcc0ae066f63	lotto6	2109	2026-06-08	{6,11,19,31,38,41}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
baab20c8-866b-4645-b2f6-25db33fe4a06	lotto6	2110	2026-06-11	{3,9,18,35,36,40}	{29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2a3e13a4-c150-46a0-8454-ea81aa8fd7f5	lotto6	2111	2026-06-15	{1,5,8,12,37,43}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d08a700b-16c5-4547-bf82-2a1ab0554fb5	lotto6	2112	2026-06-18	{3,7,8,27,31,40}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3531586b-7464-496c-ab75-7c7b535562ef	lotto6	2113	2026-06-22	{2,5,32,36,38,42}	{14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1c3fc376-e90d-4f5f-a0f7-42d9aeb1d118	lotto6	2114	2026-06-25	{2,16,20,21,23,33}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
42962167-d86a-48f6-b854-7d9389e6b596	lotto6	2115	2026-06-29	{1,3,11,34,35,42}	{23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8f170ece-351c-46b0-b2ba-8321416f9be6	lotto6	2116	2026-07-02	{2,6,13,14,20,42}	{10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
afea35af-1cc8-4085-93fc-46ce97e77b84	lotto6	2117	2026-07-06	{4,7,26,27,35,41}	{34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
03a657a5-62b3-40e2-832a-3cd35a293a93	lotto6	2118	2026-07-09	{1,5,8,35,36,37}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bdcf59e3-921c-4846-ad01-7c7cc3fcd5ca	lotto6	2119	2026-07-13	{15,18,20,22,30,38}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9df359c1-8c47-4123-9806-51cbaafe6ebd	lotto6	2120	2026-07-16	{3,8,13,14,16,43}	{26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
89fd0bf7-370f-4deb-b3f8-6b00d306daad	lotto6	2121	2026-07-20	{1,3,10,17,25,26}	{36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
783004a1-b0f7-4e18-a6f8-551315172e61	lotto6	2122	2026-07-23	{12,15,18,21,26,32}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
99a1b626-8e2b-4b03-87ea-ad500b7c4558	lotto6	2123	2026-07-27	{1,2,4,25,37,40}	{43}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
de643ba8-48b9-42cc-ad00-380d91f2e8b1	lotto6	2124	2026-07-30	{6,20,29,36,37,41}	{19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bed14c6d-bcc5-4c8a-b9b3-54b3fdd88663	lotto6	2125	2026-08-03	{3,22,25,28,30,43}	{39}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2d2af02d-18bc-4856-90b6-90ca98a9de38	lotto6	2126	2026-08-06	{18,20,22,35,37,42}	{24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
87915b07-b87d-44ff-a478-9efa38300a39	lotto6	2127	2026-08-10	{7,12,15,29,30,33}	{22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
74d2b219-5cdd-4b61-8d1a-8747810964d0	lotto6	2128	2026-08-13	{13,20,22,27,35,38}	{11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c2d43210-b566-49d4-b172-6429d9246725	lotto6	2129	2026-08-17	{2,4,6,16,25,41}	{40}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9190cbcc-8c01-4a0b-8d3a-d760d6a8aa65	lotto6	2130	2026-08-20	{12,18,35,40,41,43}	{3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ab3439ce-56dc-4244-98d7-eb8ce77034f3	lotto6	2131	2026-08-24	{25,26,28,33,35,43}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f6d03404-3302-4a08-983d-a67b711078ff	lotto6	2132	2026-08-27	{9,15,16,19,31,32}	{4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
08e25114-88ba-40f5-b54f-c491ebba3ae0	lotto6	2133	2026-08-31	{1,11,14,20,29,38}	{27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5484df40-c309-40ac-aff0-b458a5901a0c	lotto6	2134	2026-09-03	{5,9,10,19,26,35}	{18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ff98a135-abab-4277-a85f-457f46dbc568	lotto6	2135	2026-09-07	{7,13,32,34,37,39}	{41}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f58da29e-d594-46e2-b6de-3a099e32b066	lotto6	2136	2026-09-10	{6,7,33,37,41,43}	{42}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
330ecc49-b754-42af-bede-238b1c0cb754	lotto6	2137	2026-09-14	{4,8,10,25,28,33}	{9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8bb29609-8ee8-48d0-bbfa-29ccb1f75f04	lotto6	2138	2026-09-17	{9,16,21,26,38,40}	{12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
68358a7e-2e41-4f6e-909a-a6d519a93073	lotto7	1	2013-04-05	{7,10,12,17,23,28,34}	{3,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f26e3ea5-8322-43b9-b1bd-6dc10646c0cd	lotto7	2	2013-04-12	{20,24,29,31,33,34,35}	{12,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fe9a8183-349d-4b4e-b008-4d5bfd5182f9	lotto7	3	2013-04-19	{2,7,8,11,14,23,31}	{5,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0b6e515b-c69d-483c-9da3-7189a80b8b32	lotto7	4	2013-04-26	{12,13,22,23,24,28,29}	{2,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7e806f44-b44d-4cee-a003-7507354e2283	lotto7	5	2013-05-03	{1,3,4,5,16,21,28}	{22,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
960f7fca-4e4a-4f8f-ae47-56d61facf1a8	lotto7	6	2013-05-10	{5,15,19,23,30,34,35}	{6,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c53273e4-b51e-4393-8de5-7091f8e5dff7	lotto7	7	2013-05-17	{1,3,5,7,27,29,33}	{6,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
06638644-06c3-45f6-b0a6-07a357819c8f	lotto7	8	2013-05-24	{2,21,28,29,30,32,36}	{6,8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
056867f0-52d2-4e47-b4d6-0b2dd3b90f90	lotto7	9	2013-05-31	{3,4,15,23,27,30,36}	{13,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3c1391a2-800f-4df0-8643-11253de2337d	lotto7	10	2013-06-07	{1,2,3,6,24,28,30}	{16,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
cc91b87d-a7dc-4bba-9388-7d7b1475b3e0	lotto7	11	2013-06-14	{9,15,26,29,32,34,36}	{14,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2d2282dc-0f4d-4c35-956a-1b9b2ff3dafe	lotto7	12	2013-06-21	{11,12,14,19,26,27,33}	{24,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a44b2595-c598-4b32-923e-c1be4ce57427	lotto7	13	2013-06-28	{6,10,16,21,27,28,35}	{15,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1170c26f-1399-4aa0-a972-7b87c622da4e	lotto7	14	2013-07-05	{4,7,8,9,24,28,30}	{34,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
32db5541-9dbd-4e88-b6f1-52be9742ab20	lotto7	15	2013-07-12	{2,10,14,17,23,25,35}	{8,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
076bec04-94a9-40df-be87-85a7975dc033	lotto7	16	2013-07-19	{5,6,9,13,16,21,23}	{8,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e9c29f92-6942-4f6b-9317-0dbbb98c3b3c	lotto7	17	2013-07-26	{2,3,5,22,34,36,37}	{7,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6eaadc06-1d70-48fb-a562-9858b9705415	lotto7	18	2013-08-02	{12,17,21,24,29,31,36}	{20,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
57a1bf53-2ed0-4c6a-b5b0-193713fb4e5c	lotto7	19	2013-08-09	{2,14,19,20,21,22,31}	{1,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c3c7dede-0c3e-4b18-8d5f-3df7dbf246aa	lotto7	20	2013-08-16	{2,5,13,20,21,23,28}	{11,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7805f270-d92a-4888-8b58-73fc099910f5	lotto7	21	2013-08-23	{1,9,13,15,25,30,33}	{19,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fad37173-a5b3-4a5e-8f63-f400ffb999f6	lotto7	22	2013-08-30	{2,4,8,9,15,23,25}	{3,10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7352fd3f-8ce8-4935-87a9-9e0bf162ab6b	lotto7	23	2013-09-06	{4,8,11,25,28,29,30}	{14,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1d7f6173-915d-4025-9125-3db25829a4cc	lotto7	24	2013-09-13	{4,5,8,10,16,19,33}	{2,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
396abf8a-b340-43f1-904e-2a736763f36a	lotto7	25	2013-09-20	{1,6,11,16,17,18,21}	{10,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
03b68ce0-3870-4539-9491-1796b5196685	lotto7	26	2013-09-27	{11,13,16,18,26,31,36}	{21,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1b4619c4-2d35-4eb1-a55b-b3940853bbd7	lotto7	27	2013-10-04	{1,10,11,14,17,18,28}	{25,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
26e932b9-8053-403e-a289-b83afcdca27c	lotto7	28	2013-10-11	{6,7,12,15,19,35,37}	{1,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
82a211c9-a87c-4075-8e4f-e9e5486440e7	lotto7	29	2013-10-18	{2,3,16,17,24,26,28}	{15,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d2e61c79-b741-458a-902b-8fe2976d42bc	lotto7	30	2013-10-25	{6,8,13,22,26,32,36}	{16,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5118c3cc-596b-4bce-b0db-7df3b298c7de	lotto7	31	2013-11-01	{9,12,13,19,23,33,34}	{20,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c88e11ef-7801-498d-aebe-f6369ccb803a	lotto7	32	2013-11-08	{3,8,15,18,27,29,37}	{31,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fb143679-055d-44ba-9d87-41e8fc71100d	lotto7	33	2013-11-15	{1,4,17,24,29,33,36}	{19,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
86330499-5d6e-4c57-9977-9ff1f101843d	lotto7	34	2013-11-22	{4,6,7,23,24,32,35}	{8,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e7c089c7-d137-400f-8c21-6d858e2b58ec	lotto7	35	2013-11-29	{1,16,18,19,25,30,34}	{26,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8dff0f59-5cb8-4690-99ec-112f70943531	lotto7	36	2013-12-06	{5,6,10,11,20,28,36}	{25,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
23c4cd8d-6f3d-403c-ae7c-8f44e589d918	lotto7	37	2013-12-13	{7,8,10,13,14,19,37}	{29,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2018b001-1dec-4711-8ebc-713e7a76c8aa	lotto7	38	2013-12-20	{4,14,19,22,24,29,34}	{8,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
05f68732-1a44-4ea3-a94e-56489ccb0eeb	lotto7	39	2013-12-27	{7,13,19,23,25,26,30}	{1,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2e3b4c76-2e7e-4100-9d2f-c7a472cf3e68	lotto7	40	2014-01-10	{2,6,11,23,26,31,34}	{7,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a271a657-450c-430d-afd2-155a41949679	lotto7	41	2014-01-17	{2,3,8,15,34,35,36}	{25,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f921cd1e-d3b6-49cd-98f8-7b450d51ef13	lotto7	42	2014-01-24	{2,15,16,17,23,31,33}	{8,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6f0966f3-0cbe-426a-b808-41862913cfae	lotto7	43	2014-01-31	{4,6,7,8,24,31,37}	{5,13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8a183daa-bae1-49d0-a46e-43c5e8012e2c	lotto7	44	2014-02-07	{3,4,6,15,27,28,29}	{1,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ae168d76-c80f-4ba8-8f81-c16ac8185e3e	lotto7	45	2014-02-14	{1,2,9,18,21,27,33}	{25,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
79f4d9b0-c12e-4220-bf84-c0c3022b4bda	lotto7	46	2014-02-21	{2,5,6,15,23,27,30}	{4,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bd6ed315-42f4-4954-9b94-cf161623f4c2	lotto7	47	2014-02-28	{2,9,11,14,20,21,36}	{6,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
78509d95-7248-4824-9bcf-fbf92cd439ef	lotto7	48	2014-03-07	{3,5,24,26,29,30,34}	{8,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
691682f7-0912-4462-9a69-532ec56be2ec	lotto7	49	2014-03-14	{8,11,12,17,24,26,27}	{14,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
72fc8885-54c3-4156-9ef0-b37c36af5493	lotto7	50	2014-03-21	{3,4,7,8,15,24,29}	{11,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
041f4023-d589-440f-8de6-143baf0f4d91	lotto7	51	2014-03-28	{1,4,5,8,20,23,35}	{15,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ab2689e9-d9c2-421c-9f90-b63e8d8eb98a	lotto7	52	2014-04-04	{8,10,22,24,26,32,34}	{5,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9428c6fe-5f47-4e43-9a90-45bc30ae382a	lotto7	53	2014-04-11	{1,4,14,16,20,33,36}	{12,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
763cee60-82cc-4a26-924b-f65f82d163cb	lotto7	54	2014-04-18	{1,3,5,10,18,22,23}	{7,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d7a9dff6-86a7-44c8-b10a-f7c19eb25c09	lotto7	55	2014-04-25	{4,12,14,17,23,30,36}	{13,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a8cf424a-33c0-45be-97fb-2b3b7154211d	lotto7	56	2014-05-02	{4,23,26,27,28,32,36}	{29,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ea7176ab-12fe-4c59-be6d-be3904945424	lotto7	57	2014-05-09	{5,6,12,16,17,20,33}	{8,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
026a28d2-e261-4234-b9b2-9c481344619b	lotto7	58	2014-05-16	{1,6,7,8,23,32,33}	{11,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
25df0c73-0356-4a9d-b0ab-253f8a85e97c	lotto7	59	2014-05-23	{5,8,12,13,21,30,35}	{27,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
347b9246-714b-4e7f-b1be-277d25022a72	lotto7	60	2014-05-30	{3,7,9,15,16,23,34}	{5,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4b3fbfe6-f003-4378-874d-ee5a1c530f2f	lotto7	61	2014-06-06	{5,10,11,21,28,31,37}	{13,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4c20583c-6da1-4e1d-bf14-1ae7b60d28b4	lotto7	62	2014-06-13	{4,10,12,15,27,32,33}	{9,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
782b78cf-7c81-4557-a9ea-c5db6b8e2684	lotto7	63	2014-06-20	{4,8,19,24,28,30,32}	{12,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e184eca1-ea99-4a28-8ce8-d92b36ce653f	lotto7	64	2014-06-27	{4,15,16,17,20,29,36}	{19,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2aa4c984-f444-4350-82d1-f72abd926c54	lotto7	65	2014-07-04	{4,7,12,22,23,24,28}	{25,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
04770e0b-6a4c-48dd-b7be-09e8811d87aa	lotto7	66	2014-07-11	{1,11,25,28,31,33,37}	{3,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b0818198-9a3a-491e-b390-8b4e1f6dbbee	lotto7	67	2014-07-18	{7,11,15,17,18,25,35}	{6,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2c4af6da-a690-4260-86ea-786528d389ef	lotto7	68	2014-07-25	{2,7,13,15,24,34,35}	{12,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1de8378c-ff4c-4b2d-9c6e-ba828f3b9b95	lotto7	69	2014-08-01	{13,17,20,22,28,29,37}	{11,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ae230892-e0f6-4751-b2af-f66ac9e2f8ee	lotto7	70	2014-08-08	{9,10,18,21,27,33,35}	{4,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b8d85fc4-0fb3-4ee5-b029-ecb03c1c70cc	lotto7	71	2014-08-15	{1,6,13,29,34,35,37}	{2,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1502d075-b509-4c79-b5fe-2c7e27e8fe6b	lotto7	72	2014-08-22	{11,12,18,19,20,31,32}	{9,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ee4be6a1-2888-4379-be5f-ba198d104885	lotto7	73	2014-08-29	{12,16,23,25,27,30,32}	{28,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ad2ee413-6e28-46e8-8f6e-8bf00166dea3	lotto7	74	2014-09-05	{5,13,14,15,16,24,31}	{9,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b3bbda01-0d4b-4398-a06c-d567ae672cbb	lotto7	75	2014-09-12	{4,9,15,17,19,35,37}	{10,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
90c9bf52-bcba-48a6-9aa0-2124c74a24f1	lotto7	76	2014-09-19	{4,13,18,29,32,34,36}	{24,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ac1a5350-3aec-47b9-8131-8ff091a21a89	lotto7	77	2014-09-26	{3,10,23,25,26,28,30}	{15,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6f37159b-0a6a-49f6-8634-da3960ee443d	lotto7	78	2014-10-03	{5,6,10,14,24,28,36}	{7,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6ab7a20e-5aa4-4173-a2ac-4b7c917d6a86	lotto7	79	2014-10-10	{2,4,7,9,21,29,37}	{6,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e9bd0176-85cc-4cf0-8676-34b0bce16f2b	lotto7	80	2014-10-17	{2,5,10,18,21,24,27}	{25,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7a9b41aa-ea0d-4d52-90b7-52b580f82e83	lotto7	81	2014-10-24	{1,3,10,18,28,31,35}	{9,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
754e56cb-c9e1-4b09-9953-8b1593956d3c	lotto7	82	2014-10-31	{1,3,16,20,25,27,34}	{18,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
555bee62-c248-40c2-b948-f905de4ae0b0	lotto7	83	2014-11-07	{1,11,21,26,28,32,35}	{18,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bf939430-30ef-46c2-b0c5-a47062b69877	lotto7	84	2014-11-14	{8,16,23,28,29,35,36}	{12,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a2b260de-8eeb-4615-bf00-00b8468328ab	lotto7	85	2014-11-21	{6,7,10,11,22,26,35}	{14,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ba682758-f88e-40d5-aa41-771581cdbeb8	lotto7	86	2014-11-28	{3,10,20,21,22,26,30}	{24,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2588ecf3-86bb-44ba-9a72-79894afadd90	lotto7	87	2014-12-05	{8,9,12,18,20,28,31}	{13,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e4369104-ee00-4f51-9698-e96da32ab830	lotto7	88	2014-12-12	{3,4,10,14,25,29,30}	{18,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
22ff17ce-41a1-43d4-ae48-0622ffb86924	lotto7	89	2014-12-19	{1,3,11,26,28,34,36}	{17,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f44ca743-bbe0-4f36-bcc2-64d1aa7a93ec	lotto7	90	2014-12-26	{2,8,9,13,14,18,37}	{11,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
77cad48d-28e3-47ce-a22d-f2bc07cc3137	lotto7	91	2015-01-09	{1,5,7,14,15,25,35}	{18,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1596cb5d-f2cf-4e67-bfdd-1cc3d3b7b4c5	lotto7	92	2015-01-16	{4,5,15,25,26,29,32}	{11,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d7574216-c819-4039-b744-691465a2c238	lotto7	93	2015-01-23	{2,5,11,14,17,30,32}	{31,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6dd654fa-3382-470a-ab2f-6c0078d67da3	lotto7	94	2015-01-30	{13,19,20,27,28,29,30}	{26,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d193ccb5-8736-46e5-9f0f-6fc68dd36864	lotto7	95	2015-02-06	{1,8,13,14,18,30,34}	{26,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a4c3be27-da97-4f55-8de5-84be95568843	lotto7	96	2015-02-13	{9,11,14,21,22,23,24}	{10,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
83b47014-8696-4f21-8f1e-f7058dc66b6c	lotto7	97	2015-02-20	{7,13,14,16,22,24,35}	{1,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0b5bdaa9-a903-46e4-97d2-97277de42ab4	lotto7	98	2015-02-27	{3,9,11,13,19,25,33}	{10,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
de6fa84a-f1b0-4ac1-8d23-ec0bf2f5e26d	lotto7	99	2015-03-06	{13,17,22,24,27,28,35}	{11,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a67e950f-d727-4bfb-ae3b-dfeea6a2b1d9	lotto7	100	2015-03-13	{1,2,11,16,25,35,36}	{9,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5a576400-44da-497c-bbc3-198dd57c6d02	lotto7	101	2015-03-20	{11,12,21,23,28,36,37}	{3,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
12c8d0df-833a-41ee-8f41-87255832811c	lotto7	102	2015-03-27	{1,4,8,27,28,29,31}	{13,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
827a5f22-f150-4602-8942-8ba17d842119	lotto7	103	2015-04-03	{2,3,11,12,22,35,36}	{30,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d7416134-2aaa-42f6-b7e1-a0a58a3ab3c2	lotto7	104	2015-04-10	{7,9,11,15,16,22,37}	{12,13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6d9e2083-acda-49ef-924a-11bf24786985	lotto7	105	2015-04-17	{3,15,19,20,26,28,33}	{17,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ddc8c733-b410-445d-997d-0a9067de823f	lotto7	106	2015-04-24	{6,10,12,19,21,22,30}	{1,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8e05c186-782e-4990-be61-9f653cafb587	lotto7	107	2015-05-01	{3,8,9,13,17,27,33}	{29,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bb1a93be-9da3-45cb-a8eb-739cd72bfae9	lotto7	108	2015-05-08	{2,6,7,8,28,30,36}	{18,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9911470d-cfd7-4a91-8a4a-272e8be659d5	lotto7	109	2015-05-15	{6,17,20,21,24,30,32}	{7,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2220ff28-5d28-48a6-8bba-843227ed1869	lotto7	110	2015-05-22	{4,12,22,30,31,35,36}	{19,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b88ee52c-663a-4c2b-9a62-8e1d74da6135	lotto7	111	2015-05-29	{7,8,9,24,28,30,33}	{1,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
36ec6695-b5aa-4b5c-9e1b-8a1f89ed49ee	lotto7	112	2015-06-05	{6,7,10,15,27,35,36}	{13,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
84febf2c-97d6-45d3-9838-89faa88a9c35	lotto7	113	2015-06-12	{4,6,7,9,15,17,37}	{14,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
24d92d2d-d146-4026-abc8-e31fc9683e8e	lotto7	114	2015-06-19	{8,13,26,27,28,29,37}	{4,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3c3cb9eb-8637-47dc-9f21-191735aa71a4	lotto7	115	2015-06-26	{6,8,13,14,20,25,27}	{24,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
67420be2-3d84-4b25-bfda-2ffdbb405e5d	lotto7	116	2015-07-03	{9,14,23,27,28,31,32}	{3,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d49260e0-fa9b-4d72-99eb-1fba24025f5f	lotto7	117	2015-07-10	{9,10,20,28,31,34,37}	{23,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7b96b42f-30fb-4889-9223-a5fa1f75e1e8	lotto7	118	2015-07-17	{5,8,9,24,27,28,30}	{16,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
635dc4b4-6014-425a-8d09-e602c9ae6cf9	lotto7	119	2015-07-24	{3,6,8,14,15,25,36}	{24,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7af5f601-f0ba-4b7d-ac0d-a8e8230097f2	lotto7	120	2015-07-31	{2,16,18,26,32,35,37}	{9,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a87aea08-805e-441a-8069-a8917739cbf3	lotto7	121	2015-08-07	{2,4,13,16,21,30,37}	{19,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2ba16ce7-2aaf-48bd-a6b2-ae617e30603a	lotto7	122	2015-08-14	{2,16,18,26,27,34,35}	{5,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d03af174-8985-4e36-9dec-40f36debaf6d	lotto7	123	2015-08-21	{1,3,5,8,29,34,36}	{23,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
aa4e4689-b453-45da-9cff-30f295a80380	lotto7	124	2015-08-28	{1,2,15,17,18,22,36}	{6,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dbfe0885-08b3-4ed9-a729-2b8c31ca6845	lotto7	125	2015-09-04	{1,6,11,14,19,28,35}	{18,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d16a8d3a-ba31-491d-99fe-3c21d05ca46d	lotto7	126	2015-09-11	{4,10,13,16,17,21,27}	{1,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ec8f3e0d-b252-4b71-8f60-84779448bdf0	lotto7	127	2015-09-18	{10,12,15,23,28,30,35}	{6,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1cd73ee2-1f8c-4699-a8e1-209f3bd67369	lotto7	128	2015-09-25	{2,4,8,23,26,27,32}	{3,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ce983bd7-d3e6-4ef0-89d9-f1129376a61d	lotto7	129	2015-10-02	{5,7,11,19,24,27,30}	{29,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
492eefaa-ee55-4379-b0bc-b3a4c5028d4b	lotto7	130	2015-10-09	{1,15,20,23,25,31,32}	{5,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7e2938b0-bc29-4e86-b940-b0967ea1e64b	lotto7	131	2015-10-16	{3,4,12,17,32,34,36}	{23,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6589a951-7958-4f8a-9889-ea133b27a1ef	lotto7	132	2015-10-23	{7,10,14,16,20,30,31}	{35,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8d87d345-f440-48bc-ac4e-09e2a6d7fe1f	lotto7	133	2015-10-30	{3,7,13,15,17,21,30}	{14,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a30fd0ec-59e8-4cf0-ab5b-9f78cee264b4	lotto7	134	2015-11-06	{4,9,20,28,30,34,35}	{12,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ac9238ca-df3d-46af-a190-5308f36cc552	lotto7	135	2015-11-13	{8,9,13,14,24,32,34}	{3,4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
84527914-e7cf-4f5d-9573-fffbb19d2a50	lotto7	136	2015-11-20	{10,17,24,27,30,33,37}	{18,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
200fb5db-39be-4fe1-8bf9-0f507d719e61	lotto7	137	2015-11-27	{13,19,21,25,27,32,35}	{16,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ac2a2d3d-aa26-4f53-9ffa-6abe6e5c489e	lotto7	138	2015-12-04	{2,5,17,20,21,32,33}	{30,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8da45dda-a941-4d4d-b63f-2e861e912088	lotto7	139	2015-12-11	{9,16,18,21,23,34,35}	{4,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bc879555-8ea6-4774-91ce-061779aca6dc	lotto7	140	2015-12-18	{3,11,12,13,17,26,35}	{1,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4fb1752c-d5eb-4ffd-9641-72cd5e1558b8	lotto7	141	2015-12-25	{2,10,18,30,31,32,36}	{21,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e65c1b3d-4eac-4eb1-8e0b-c6a790f06ced	lotto7	142	2016-01-08	{6,12,14,18,21,27,28}	{1,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
552d24a4-bca9-4f53-9822-a88b3403aa9f	lotto7	143	2016-01-15	{1,3,8,14,28,29,33}	{4,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b53450c9-a6a7-46c1-a20a-fc72a76b88b2	lotto7	144	2016-01-22	{2,9,13,18,22,32,36}	{17,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9f622864-52f1-45cf-b91b-13fb652914c8	lotto7	145	2016-01-29	{10,12,18,28,29,30,35}	{4,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ed9b3ea3-3d2d-4380-ae3f-b958361d1732	lotto7	146	2016-02-05	{4,10,25,27,28,33,34}	{15,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fefd8af3-b6d9-4857-80b9-b7d33ad15c7e	lotto7	147	2016-02-12	{1,5,7,12,15,24,25}	{8,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d3fdd5d7-5441-4a77-a940-351ccfa17b09	lotto7	148	2016-02-19	{1,9,11,16,20,30,34}	{12,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7dc927bd-98fb-4d5e-85d4-3012672c6f89	lotto7	149	2016-02-26	{1,4,15,19,22,23,31}	{12,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4af0b0e1-ac71-4c41-8911-7262701c59cb	lotto7	150	2016-03-04	{6,7,14,20,27,31,34}	{11,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
26ef773c-d6bc-4525-affa-abbd7f1e8874	lotto7	151	2016-03-11	{9,10,13,15,21,22,24}	{4,8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3350aa1d-2db5-4942-8a64-8e53b9ac36b6	lotto7	152	2016-03-18	{8,12,17,21,23,24,31}	{6,7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1938aefa-79cd-4c4f-afa6-0647aa180d87	lotto7	153	2016-03-25	{7,9,10,16,20,28,37}	{2,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3bc4f1a8-5460-47ba-b0f4-8741d4bddcef	lotto7	154	2016-04-01	{2,4,19,21,24,28,35}	{3,13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b0f63e24-48fb-401b-a209-1df8c2b6b3d0	lotto7	155	2016-04-08	{2,9,13,18,22,24,26}	{10,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c092f960-9bf2-49b5-87ff-ccb96e1adb4b	lotto7	156	2016-04-15	{4,9,16,19,22,33,34}	{17,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3f03d8c2-47fc-4416-adfb-ac6147fcce24	lotto7	157	2016-04-22	{5,9,16,26,28,29,32}	{1,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1d542ce6-1f3c-4bf9-adfe-42b7e9d67279	lotto7	158	2016-04-29	{3,6,7,30,32,36,37}	{5,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7fedd548-47c7-43a6-9771-2843a4e02cd6	lotto7	159	2016-05-06	{10,14,17,21,23,27,31}	{16,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5fc05d0a-f579-4f78-836b-6b2fd34f8beb	lotto7	160	2016-05-13	{1,2,8,24,32,36,37}	{23,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bc307dad-83f1-40ef-a120-bd5e46d55721	lotto7	161	2016-05-20	{8,14,17,18,20,22,34}	{4,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
26a9306b-ffe0-4f08-9d16-e8c929b02a1d	lotto7	162	2016-05-27	{2,7,8,12,14,23,27}	{6,10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6875dae1-1cd8-4656-87d4-e661e08a6d34	lotto7	163	2016-06-03	{1,2,6,16,28,30,31}	{3,7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9eb707bf-72ab-4eb9-b9fc-168b842ad3eb	lotto7	164	2016-06-10	{3,13,20,23,31,35,36}	{2,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d428b0e0-00c2-4815-94e6-fe14fb132acd	lotto7	165	2016-06-17	{9,11,14,15,16,18,27}	{6,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9ae984f9-e926-42a2-b184-18c95ba0dc0f	lotto7	166	2016-06-24	{14,20,27,29,30,31,37}	{23,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d65e3588-4dea-490d-a043-4f56c9df6a09	lotto7	167	2016-07-01	{1,3,5,7,10,26,36}	{19,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
40ef1d4d-c0e6-44ff-8be2-bb94be19a3fc	lotto7	168	2016-07-08	{3,9,12,14,19,20,36}	{2,5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
40dc5827-4949-4cff-b477-305a52f96d5a	lotto7	169	2016-07-15	{1,5,10,20,21,28,30}	{25,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f228a1e4-1ff0-4899-ae51-44e5bec160fe	lotto7	170	2016-07-22	{3,5,6,9,27,32,36}	{12,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4bb7b3b3-6f87-45f0-b85b-a23076832e49	lotto7	171	2016-07-29	{1,2,6,21,23,27,28}	{11,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
28b4205d-fb35-44b0-857d-6233f8cbe49a	lotto7	172	2016-08-05	{5,20,21,27,30,31,36}	{9,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b1795a0b-892e-4a86-aac0-8338e47a33f7	lotto7	173	2016-08-12	{7,9,19,22,24,27,30}	{4,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
34575fad-0d94-4bb1-9e68-827a0affbcde	lotto7	174	2016-08-19	{10,13,14,15,23,31,32}	{4,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3a285cc0-152a-4284-8420-06d56312dcba	lotto7	175	2016-08-26	{6,17,21,31,33,35,37}	{14,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
eec9ccc7-9142-40ff-aee4-1f053b5779e4	lotto7	176	2016-09-02	{1,11,12,17,22,30,35}	{15,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
818e04cf-b1fd-4449-9db9-d0c696e9ae00	lotto7	177	2016-09-09	{9,15,19,23,25,34,36}	{2,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2f5bbd24-c444-4c9e-be7a-2421dbfb7845	lotto7	178	2016-09-16	{6,9,11,15,26,34,36}	{13,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
79e76744-ae19-4d12-8592-b1992c0ba31d	lotto7	179	2016-09-23	{4,9,12,13,22,26,36}	{5,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ddb41236-aac8-48eb-a707-a0ca97109174	lotto7	180	2016-09-30	{1,8,11,21,23,25,28}	{5,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8cf166c5-0707-4442-9b9b-0f6feee7d264	lotto7	181	2016-10-07	{7,8,10,13,19,23,24}	{15,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6698c16d-5707-4b68-b988-196ec9118339	lotto7	182	2016-10-14	{1,7,10,11,20,23,30}	{3,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3be8e70c-a9c4-45c1-9123-fec8708c6e90	lotto7	183	2016-10-21	{6,15,20,26,33,34,37}	{19,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
36fa8d08-b631-46f2-aa8a-c2d8f1700954	lotto7	184	2016-10-28	{7,14,18,22,23,26,34}	{2,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d63a9a3a-69fe-40e7-8dc9-548bdb7001de	lotto7	185	2016-11-04	{1,2,4,16,26,29,34}	{11,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8a317507-0b88-4ef0-9120-f61b7ddb0f98	lotto7	186	2016-11-11	{5,14,16,19,31,33,37}	{21,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
44d0e88f-2ebe-4bf7-8db6-fb8556ace1b9	lotto7	187	2016-11-18	{4,6,10,23,24,32,36}	{15,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d1fa3164-567f-41a4-b509-b40419c535d9	lotto7	188	2016-11-25	{6,15,19,25,26,30,31}	{14,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
92458e4c-e4a0-43fb-ade7-0ee2b18fcc55	lotto7	189	2016-12-02	{3,7,8,10,18,23,35}	{1,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
95d18aaf-25e6-4cdb-98b4-d5ce584060a8	lotto7	190	2016-12-09	{2,11,12,18,21,33,36}	{8,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2b32596b-fdcc-4edb-b936-34df85f9f6d3	lotto7	191	2016-12-16	{8,15,21,24,26,27,29}	{7,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9a82de40-2360-4520-956f-bc933b0ca6a7	lotto7	192	2016-12-23	{12,13,14,19,25,33,34}	{3,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a28a58e6-0815-4ad7-bd61-6a3df6a81565	lotto7	193	2016-12-30	{4,6,20,21,22,24,31}	{9,10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
00f994ff-7b90-4b72-ae8f-ab83da31535f	lotto7	194	2017-01-06	{3,6,27,30,31,32,36}	{14,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
223f7468-e711-4378-9ed8-e1de36d2cdc8	lotto7	195	2017-01-13	{4,7,12,20,23,24,31}	{26,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
de09ebfa-0368-4a5a-902b-c225bec17d82	lotto7	196	2017-01-20	{7,13,15,25,30,32,37}	{8,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
735d521c-905a-488d-92c4-e1d56404d293	lotto7	197	2017-01-27	{6,8,10,12,16,21,28}	{14,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e3337600-bef4-42f2-b477-d98c4047fec4	lotto7	198	2017-02-03	{18,21,31,32,33,36,37}	{5,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8c5334e4-6016-48ea-9c9c-40d68a2f4a92	lotto7	199	2017-02-10	{1,9,17,20,22,28,29}	{13,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4476e440-a35b-4acc-829d-93b556fe095c	lotto7	200	2017-02-17	{13,14,17,21,27,28,34}	{1,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d26c54be-988d-4c0f-9fce-f6d0da6ac5c9	lotto7	201	2017-02-24	{8,11,17,24,28,31,32}	{12,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9da31066-758b-4b90-a00f-e69a5feeb2cb	lotto7	202	2017-03-03	{3,7,11,16,22,34,37}	{29,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
54d64eb5-df88-4169-85da-0fdc22f55589	lotto7	203	2017-03-10	{6,13,17,22,32,33,36}	{12,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7e1bdb6f-c3ce-48db-b811-5d5bc6609346	lotto7	204	2017-03-17	{5,19,20,21,30,34,36}	{7,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c90d09d1-42e8-4f45-b97a-498e6cfe3f2e	lotto7	205	2017-03-24	{4,5,19,31,35,36,37}	{27,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fb163e4d-1fd6-4d81-9dce-0c2fe11a9c75	lotto7	206	2017-03-31	{1,6,7,11,27,35,36}	{22,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
040fe875-c2a7-4bdd-9cef-643d589fb02b	lotto7	207	2017-04-07	{4,5,10,13,28,32,33}	{19,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0ac432b6-3f21-4df4-a089-a41fc29991ed	lotto7	208	2017-04-14	{4,13,16,18,22,26,33}	{27,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
00faf10c-46ea-406d-9ef3-4f08af581aaa	lotto7	209	2017-04-21	{3,4,6,13,22,31,36}	{28,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d7c8a70d-5abf-4762-bce6-fcd8a0c38d9f	lotto7	210	2017-04-28	{2,4,6,11,15,19,36}	{23,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
aeb7c7f0-1dae-43d4-a13e-61fcf6bc7f32	lotto7	211	2017-05-05	{7,15,22,25,31,32,35}	{29,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
12ba0d75-bf8e-4fd9-9f0d-d82c52d4e030	lotto7	212	2017-05-12	{4,6,10,19,20,24,29}	{1,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d1afc90b-1b69-440c-915b-233243ff5919	lotto7	213	2017-05-19	{5,13,15,18,19,24,35}	{20,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e07fb95c-2932-4088-bdc2-f107eccd86c0	lotto7	214	2017-05-26	{2,6,9,12,31,36,37}	{3,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
73887563-7fcb-4eb0-871d-48644f2e43e2	lotto7	215	2017-06-02	{11,12,13,21,29,36,37}	{7,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0ff21c79-0e8a-46f8-a99f-f6025221e139	lotto7	216	2017-06-09	{9,14,22,24,25,36,37}	{8,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a959b0d6-d8db-4b2c-8ac5-a0e35f82c624	lotto7	217	2017-06-16	{4,6,26,27,28,35,36}	{24,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
782939a0-6af8-4746-a6aa-256c5bdd51b0	lotto7	218	2017-06-23	{15,16,17,21,26,29,30}	{10,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
00a014ed-c3d0-4f7c-bce4-dbd2343761ff	lotto7	219	2017-06-30	{6,9,13,14,21,25,31}	{2,4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fc5bce8c-6074-4c00-bf3b-64b59889119a	lotto7	220	2017-07-07	{7,9,11,18,25,28,35}	{20,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1c76b475-c9f8-45ff-b64a-04c6d89865e0	lotto7	221	2017-07-14	{1,2,9,11,17,30,35}	{13,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dd00edd7-a9f9-4623-9cae-28f78233d851	lotto7	222	2017-07-21	{3,9,18,21,23,27,29}	{35,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
034fc013-6f7b-44a2-8a22-e028f6bdc548	lotto7	223	2017-07-28	{10,13,19,21,26,33,34}	{24,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bfdbd126-d5d9-4e5b-b3bc-4755281070a0	lotto7	224	2017-08-04	{2,4,7,10,12,29,34}	{1,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e82f3609-8612-4945-a378-b82c7811b27a	lotto7	225	2017-08-11	{13,15,17,18,20,21,26}	{25,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dbd8ad9f-1b4c-4521-9286-45d6186c44b5	lotto7	226	2017-08-18	{12,17,21,24,26,30,32}	{10,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
89671c53-813f-40bc-a125-ffa9dbcc102b	lotto7	227	2017-08-25	{2,3,7,9,22,23,26}	{29,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ba608234-d4cf-4492-9c13-fb6c5dad1dec	lotto7	228	2017-09-01	{6,11,14,21,24,28,31}	{22,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e3460ded-ea07-4a93-b47f-7b4d8a3de4e5	lotto7	229	2017-09-08	{2,3,9,30,33,36,37}	{1,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2e624e46-0c08-4a56-9010-cbc89d13687c	lotto7	230	2017-09-15	{3,5,8,15,22,25,27}	{18,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c99804ab-ce99-470b-bdc2-cc6e12459c94	lotto7	231	2017-09-22	{4,15,18,24,25,34,36}	{10,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b4bd1cf3-4d82-48d3-844e-3f9078a2b615	lotto7	232	2017-09-29	{2,4,7,9,15,35,37}	{10,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4f92c9c9-a9c9-459f-a815-b83dd26bc15b	lotto7	233	2017-10-06	{3,13,17,25,26,27,29}	{8,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
77f60343-8ab1-42af-a65b-9dcc3ed6523f	lotto7	234	2017-10-13	{7,14,15,16,23,25,30}	{5,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d5bddc00-f8df-469f-954d-a26a1565bbc6	lotto7	235	2017-10-20	{2,9,13,18,21,33,34}	{3,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9c2f14b2-2d55-4b44-8e45-3d9382ad947c	lotto7	236	2017-10-27	{19,22,23,34,35,36,37}	{10,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a8656106-1102-4015-b668-9c485ca5a409	lotto7	237	2017-11-03	{3,4,7,19,20,21,29}	{8,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fa9f871b-cb2d-40db-b908-0ff15e46e86e	lotto7	238	2017-11-10	{3,21,26,33,34,35,37}	{23,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a9f69957-0917-4dee-a016-c7d17c79ea91	lotto7	239	2017-11-17	{8,13,17,21,23,28,37}	{1,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d131f6f7-c2fd-44b0-a14c-c944df98a1bc	lotto7	240	2017-11-24	{9,12,14,24,29,31,35}	{5,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
db6fe421-bfb6-4a9f-ab82-e17c29839ed3	lotto7	241	2017-12-01	{5,11,12,19,21,26,28}	{4,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
08ef720d-f3a6-438f-a57e-d951436ac924	lotto7	242	2017-12-08	{1,5,13,17,31,32,35}	{19,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e0a67fa6-a17b-477e-8c1e-bd5d6bee0a3d	lotto7	243	2017-12-15	{6,9,13,18,20,22,30}	{11,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
04d080d2-f18b-4d91-ad35-d0abb5cfb5ef	lotto7	244	2017-12-22	{2,9,17,22,32,34,36}	{11,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
48f4415f-de1c-4bb0-85e3-4935d099b487	lotto7	245	2017-12-29	{2,8,9,11,24,26,27}	{7,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e08d7a4d-b23e-47c7-9779-84fb7e9ab454	lotto7	246	2018-01-05	{3,6,9,19,23,25,31}	{21,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
87bfaec5-d82c-4400-8483-5679ea518f78	lotto7	247	2018-01-12	{10,12,13,16,34,35,36}	{11,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c3e7189f-5918-4169-8e8b-9204a1ae5136	lotto7	248	2018-01-19	{1,5,6,22,25,27,31}	{12,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7e14e068-63ac-47bf-a766-4c436f11328b	lotto7	249	2018-01-26	{9,20,28,29,31,34,37}	{5,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
87b0917e-a4a7-4360-989f-2913414f3565	lotto7	250	2018-02-02	{5,9,10,13,26,30,34}	{18,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e866d752-bf3d-4a77-bcee-c736aa04fb79	lotto7	251	2018-02-09	{1,15,20,26,28,34,37}	{23,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f1196104-50be-4008-97f1-32f7d23a4ef5	lotto7	252	2018-02-16	{8,23,24,25,27,30,31}	{11,17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
defa8cf5-6aa1-4f34-8fed-4c439972d5b6	lotto7	253	2018-02-23	{6,7,9,12,15,17,24}	{26,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
73d807d7-fa5a-4455-9ee9-8b51aaa67fb6	lotto7	254	2018-03-02	{1,12,14,18,23,24,31}	{7,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
da33bcae-be0b-483e-b9b4-a2023cdad859	lotto7	255	2018-03-09	{1,4,11,13,15,21,32}	{5,10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7cb71e62-6692-4181-b8fc-87c171ca776b	lotto7	256	2018-03-16	{14,21,24,27,30,33,37}	{19,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
da3e4e49-730d-4bb9-8a9d-67d71670de58	lotto7	257	2018-03-23	{5,15,16,26,27,32,35}	{23,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ebe56e5e-4683-4f7b-be8c-f9556d8b729e	lotto7	258	2018-03-30	{1,3,11,20,23,32,35}	{25,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
374efccc-84f3-44dc-996f-cd6471e110cc	lotto7	259	2018-04-06	{5,6,15,19,22,29,32}	{4,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7b45abbe-8ca8-4a8e-8c85-3527ccdf6f74	lotto7	260	2018-04-13	{4,8,12,23,29,31,34}	{5,6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8617b518-a6f5-4253-899e-b0b8e69ef19f	lotto7	261	2018-04-20	{4,14,15,17,21,23,26}	{7,8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
406f8f21-d4e2-4247-9770-610d4634a9f7	lotto7	262	2018-04-27	{2,6,7,9,19,23,36}	{5,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4bac5ad1-bbc1-4a09-8f04-5579acaf39d3	lotto7	263	2018-05-04	{1,5,11,16,27,35,36}	{6,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2c45ef47-14f7-418b-a275-45dd33c70abc	lotto7	264	2018-05-11	{8,13,15,17,21,26,29}	{4,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1dfdac89-ef93-426b-aae3-ec5c00fbdc4c	lotto7	265	2018-05-18	{12,13,15,19,21,24,36}	{10,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6b775bc5-a91c-4446-867f-ee85246b1d3d	lotto7	266	2018-05-25	{6,11,15,17,20,27,32}	{16,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
82fa54f5-64ab-447e-8b39-20b4ce064cba	lotto7	267	2018-06-01	{8,13,18,20,23,25,26}	{6,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7feef050-ced3-4746-b7a3-1f59b96e2ea7	lotto7	268	2018-06-08	{4,5,9,15,29,31,33}	{26,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0e35d379-69e4-4b83-aab0-615945b7d138	lotto7	269	2018-06-15	{1,9,15,24,31,33,36}	{2,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
377ce217-87e3-48aa-aa9a-a060f477af4d	lotto7	270	2018-06-22	{1,2,11,13,15,24,25}	{26,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8901c8c9-617c-4260-9a23-b0d9df821a79	lotto7	271	2018-06-29	{1,9,15,16,19,32,35}	{14,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ab952426-0cab-4e02-8837-4072bf2ae000	lotto7	272	2018-07-06	{2,5,8,15,18,26,31}	{19,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
db8a1f45-e9c2-40c6-bc32-45a5281bff20	lotto7	273	2018-07-13	{13,15,21,23,26,32,34}	{5,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
18d1efe4-b2ae-4f69-b66c-72527a4eb3d7	lotto7	274	2018-07-20	{9,14,21,23,25,26,37}	{7,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
10de3648-6d52-452b-91c9-3b1564a8d835	lotto7	275	2018-07-27	{8,9,15,19,24,25,35}	{34,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dff43f5b-ed3f-4de6-ad92-f0520dd103d5	lotto7	276	2018-08-03	{3,6,12,17,22,34,35}	{2,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fd277365-5c02-4ed2-bd82-16bdf5da9039	lotto7	277	2018-08-10	{6,7,9,11,21,23,25}	{1,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
05dd3d4b-8f7e-4626-a972-623625b93bea	lotto7	278	2018-08-17	{6,9,14,21,23,33,36}	{27,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
39030c1a-2b24-4031-948e-7e6d84a62dbe	lotto7	279	2018-08-24	{7,11,15,17,19,23,31}	{9,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9eca965d-010e-4abc-8aa2-dd6ed55c3ae6	lotto7	280	2018-08-31	{4,9,10,11,24,32,35}	{2,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0418086e-0c0f-4751-8f19-0fa9cb04c720	lotto7	281	2018-09-07	{1,2,17,19,20,22,26}	{30,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8a930f49-c8e0-4906-8cd9-03fa697ee36a	lotto7	282	2018-09-14	{10,17,18,25,29,35,36}	{7,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5b6d9ee9-6f5a-409b-8b7f-e08827c130de	lotto7	283	2018-09-21	{13,14,15,17,23,29,31}	{10,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bafddefd-0737-4cb3-963a-41d83d2e250c	lotto7	284	2018-09-28	{6,7,10,25,29,30,33}	{1,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7d04b5f8-d739-4eaf-b5c1-95c381a2f6e1	lotto7	285	2018-10-05	{11,15,21,26,30,34,35}	{4,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
78fff2bd-5747-43d4-ab09-4e34246c08e0	lotto7	286	2018-10-12	{4,5,14,17,18,29,37}	{27,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
790c0de6-14f4-4af1-8b99-141fc08cf13e	lotto7	287	2018-10-19	{2,7,10,20,24,29,34}	{4,8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
83fb9214-4ef8-48aa-820c-297070dfa32f	lotto7	288	2018-10-26	{1,8,9,16,27,32,37}	{17,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
45ce685e-c4b0-47c5-99b9-d4d3e8c74d15	lotto7	289	2018-11-02	{2,7,10,12,16,17,34}	{23,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c6543353-9b43-4b61-9a61-feb8523475b7	lotto7	290	2018-11-09	{3,13,22,26,31,32,37}	{29,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
62e80d68-2348-4659-872a-109c6830cceb	lotto7	291	2018-11-16	{1,11,18,19,21,29,37}	{5,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ad8a537b-8575-4ee0-abc5-1507fe399a06	lotto7	292	2018-11-23	{12,15,25,26,27,29,35}	{24,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e1f8ea6f-12a4-42f8-838f-91b06eede45d	lotto7	293	2018-11-30	{11,13,15,20,27,29,35}	{1,7}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
820b01f9-e2e5-4090-914a-79c090002d18	lotto7	294	2018-12-07	{3,4,6,10,14,22,29}	{28,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
011c0e99-52bc-49b6-a5be-64007ce4d8c7	lotto7	295	2018-12-14	{4,5,6,8,9,22,32}	{13,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a01271f7-6e4a-40c6-85cf-929f66a1fc73	lotto7	296	2018-12-21	{1,8,10,12,18,28,29}	{25,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
46b7f3a2-5dbe-41fa-80ae-2ef2e7fa897b	lotto7	297	2018-12-28	{2,3,11,16,23,28,36}	{8,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
40fc6759-ff5a-41c6-8510-fc487e57c1c9	lotto7	298	2019-01-04	{1,3,8,11,18,19,22}	{26,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b189f8bb-9b10-44c0-b636-8b92dfad430c	lotto7	299	2019-01-11	{1,6,10,13,16,26,36}	{28,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b0800f78-afd3-47ab-b323-1c9a4fbd1a39	lotto7	300	2019-01-18	{4,7,21,31,33,34,35}	{6,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b1c37900-92ee-412c-9cf1-4f4475361fc4	lotto7	301	2019-01-25	{4,11,12,25,27,30,33}	{5,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b2700f66-604c-464e-9918-ec1ee7fe52e5	lotto7	302	2019-02-01	{8,16,26,27,28,32,34}	{4,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f7d11381-9429-443b-91b6-d6d16518e359	lotto7	303	2019-02-08	{4,7,14,17,21,34,37}	{10,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ce5ad455-caad-4885-a58b-9916f0802c62	lotto7	304	2019-02-15	{7,9,10,17,28,33,36}	{18,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
14ecbac6-4f07-4bf3-b7ae-274c8c8da1b7	lotto7	305	2019-02-22	{6,17,23,24,27,28,31}	{10,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a08bc416-e90c-4f92-b825-d1feba87fa95	lotto7	306	2019-03-01	{12,13,15,22,25,33,35}	{1,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
af841b4f-baa6-415b-bbd0-762bca2088f4	lotto7	307	2019-03-08	{5,8,15,24,25,32,35}	{20,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7d3e7d57-e1c1-443b-b9cb-cd1f400791ce	lotto7	308	2019-03-15	{5,6,11,15,20,32,33}	{13,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b9856ba9-c658-43ac-a3f5-95d26df45ba0	lotto7	309	2019-03-22	{1,7,13,14,16,21,22}	{18,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
20b254eb-d08d-46f6-9fe0-a978b2f3b7d7	lotto7	310	2019-03-29	{17,25,26,28,31,32,37}	{6,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
10dc990e-61c4-4cec-923b-a85f90dcba7d	lotto7	311	2019-04-05	{9,11,18,24,26,27,37}	{30,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
011cd046-b5fa-4826-bbac-9718e68035a1	lotto7	312	2019-04-12	{1,2,4,18,20,29,34}	{17,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2b2facf9-52c7-47b9-967d-40bcf5444666	lotto7	313	2019-04-19	{9,13,16,23,28,29,30}	{1,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2faf724a-6725-46ab-b24c-0b2a8dd89a26	lotto7	314	2019-04-26	{3,6,8,19,32,34,35}	{12,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ee88f04a-bdcd-47a4-94b7-58fea9e4b26a	lotto7	315	2019-05-03	{3,11,18,26,30,33,37}	{28,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2c325274-02ff-4bd8-8332-f58b23d0e8cf	lotto7	316	2019-05-10	{3,9,10,17,30,33,34}	{6,8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7383e82d-229e-48bd-a34d-f2577f6fbd8b	lotto7	317	2019-05-17	{7,8,14,15,16,20,29}	{18,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0f0ba95c-c93a-41ce-a6e1-6135db79b2fa	lotto7	318	2019-05-24	{4,5,10,12,27,34,36}	{3,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
31be87c3-6ba1-4961-bb2d-fa2ce5f446bc	lotto7	319	2019-05-31	{2,6,14,23,28,31,35}	{19,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5c540cee-fa84-4826-815c-2c47ecbe8b1c	lotto7	320	2019-06-07	{5,6,18,22,26,33,34}	{36,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9b3ad422-be4e-4dc7-ba66-7547aba09397	lotto7	321	2019-06-14	{15,24,27,28,29,34,35}	{9,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9133cb81-dfbc-4bd5-9ff8-555d7f24dc0e	lotto7	322	2019-06-21	{1,10,11,21,26,29,30}	{14,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ecdb07d1-6245-40c3-96a5-db7d19ceee26	lotto7	323	2019-06-28	{11,14,15,21,26,34,36}	{23,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
17e5e9b5-7f02-46bc-ac41-1f4fe30949c0	lotto7	324	2019-07-05	{9,13,16,17,18,19,20}	{30,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
342ffde1-d022-4d68-9e66-396500423a10	lotto7	325	2019-07-12	{4,14,17,18,21,31,33}	{6,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
71964e94-b01d-4cd0-b909-f22c10332d86	lotto7	326	2019-07-19	{1,2,17,18,24,27,29}	{12,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3ca6c707-b58b-4358-bd2d-ff6000034269	lotto7	327	2019-07-26	{1,3,13,14,16,30,31}	{2,17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
38c572ba-497c-405a-afe9-3bf303f2c75f	lotto7	328	2019-08-02	{3,9,10,14,19,24,30}	{18,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dabffb7a-8ff7-47ee-bf84-fc246197800f	lotto7	329	2019-08-09	{3,10,19,20,26,28,30}	{15,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
65f33407-0f49-42cc-bbe8-48a27dee5a69	lotto7	330	2019-08-16	{3,4,10,12,17,18,20}	{19,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9847da9a-f2e8-426c-8138-b5bbc5743fff	lotto7	331	2019-08-23	{5,7,11,12,15,18,20}	{19,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
678c5557-7d58-4cfb-9f2f-f74b0d0784aa	lotto7	332	2019-08-30	{5,7,10,15,24,27,30}	{3,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8698c1d9-57ca-48ad-8725-3055e0ba7f9a	lotto7	333	2019-09-06	{1,4,10,11,16,24,34}	{30,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8292b50a-dd99-4c3c-986f-8f4ec3e63283	lotto7	334	2019-09-13	{3,7,15,16,30,34,35}	{8,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4bbff829-b1bf-43ae-a032-9755f0a98239	lotto7	335	2019-09-20	{9,10,17,18,22,25,35}	{13,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
26929ab4-453f-4bd5-ae04-503077156b50	lotto7	336	2019-09-27	{9,10,13,21,25,31,33}	{24,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
10b82104-4c47-45b8-a12e-8528088c1528	lotto7	337	2019-10-04	{5,7,10,12,14,24,35}	{11,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dc81b652-5029-4a1a-8400-521a4ed35616	lotto7	338	2019-10-11	{7,9,16,17,23,27,34}	{15,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3a447796-8c6b-4605-a174-59d4c7cc29cb	lotto7	339	2019-10-18	{11,15,18,20,23,25,32}	{9,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8aa16df2-a39c-49aa-a234-53258b4aac01	lotto7	340	2019-10-25	{6,14,17,26,27,30,36}	{12,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
68e619fc-721d-4ccf-b1d2-0bbc7fad0763	lotto7	341	2019-11-01	{4,11,17,27,29,31,36}	{19,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
362da20a-9a43-4b5a-a394-2821f866926e	lotto7	342	2019-11-08	{3,6,24,28,32,35,36}	{4,8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3556f524-f1f9-449d-83dd-b646ddbc28d1	lotto7	343	2019-11-15	{17,19,22,29,30,31,32}	{11,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3f1b7b95-9eb4-43cd-88c2-91f440ca74d4	lotto7	344	2019-11-22	{11,19,28,29,31,32,37}	{12,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2923c939-12f8-4404-9a61-fb9c5adb1672	lotto7	345	2019-11-29	{6,9,10,18,28,31,32}	{24,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2329eed1-06e4-4977-a6d6-6fba6b520e75	lotto7	346	2019-12-06	{11,16,18,23,30,31,35}	{3,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3b8a4c15-b426-4c6b-8ee5-da642d0b4f33	lotto7	347	2019-12-13	{3,6,11,13,18,20,34}	{25,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
264a3586-66f6-4d85-b9ef-004b10009711	lotto7	348	2019-12-20	{2,5,17,18,19,20,33}	{1,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9035a5d9-20e2-48ac-a7a4-758696997b87	lotto7	349	2019-12-27	{4,10,11,15,18,22,34}	{16,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f84fdd9a-f403-4d27-accb-7c474e1fb1ae	lotto7	350	2020-01-10	{10,19,21,23,24,30,37}	{2,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
04efdcd3-7a9b-4dd1-8d3a-dffaab034cf1	lotto7	351	2020-01-17	{8,13,17,19,23,25,28}	{5,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0c3f7333-de71-4b47-b65d-1bb26ae7d909	lotto7	352	2020-01-24	{3,4,14,18,26,30,32}	{28,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6efaf546-0968-442e-9492-16aae7ce6009	lotto7	353	2020-01-31	{11,15,22,23,24,29,33}	{19,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
595bc7c0-3c41-4c03-b76b-fa51a7db2ec0	lotto7	354	2020-02-07	{1,2,8,10,13,25,31}	{23,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
829f2fb7-b867-4f35-aeba-757805c8834a	lotto7	355	2020-02-14	{4,6,9,10,23,27,33}	{14,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c6a481ce-4783-43ba-9538-4b0bff1f3e2b	lotto7	356	2020-02-21	{4,16,20,30,33,34,36}	{19,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
674b83ec-89d3-483e-8ca7-84674ac3cc2f	lotto7	357	2020-02-28	{5,8,12,13,14,24,30}	{27,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9a1625b8-2a8b-45cc-8034-04965a6b1e98	lotto7	358	2020-03-06	{5,13,14,26,32,33,34}	{8,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9fb8fda3-6ebb-4e36-904e-f0230346a921	lotto7	359	2020-03-13	{4,7,11,17,19,26,35}	{1,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
22a9ee03-590e-4176-bdb0-f9e9e6f4e659	lotto7	360	2020-03-20	{9,11,13,14,20,22,37}	{15,17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f98db880-fad0-4c04-a1c3-096bbb32ad7e	lotto7	361	2020-03-27	{5,9,16,20,29,33,35}	{2,8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
edb04e21-0511-4fdb-a3d8-685531cf885a	lotto7	362	2020-04-03	{4,7,8,14,22,24,27}	{13,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
00ac019a-2839-48dc-85dd-a6fab59777ed	lotto7	363	2020-04-10	{13,15,17,22,26,34,36}	{3,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
65eff18e-22fc-47a1-a57c-5f25e0c9aaa5	lotto7	364	2020-04-17	{3,9,10,14,16,20,27}	{19,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7cad0842-325e-4065-bd81-7e00a627d742	lotto7	365	2020-04-24	{1,4,13,14,16,22,35}	{10,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1cf9ced6-6397-45df-bf13-d4675af6766e	lotto7	366	2020-05-01	{10,24,25,26,27,33,36}	{4,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e818c3e9-4c90-413a-acd6-5e8b63f6f07a	lotto7	367	2020-05-08	{8,14,19,20,29,30,31}	{7,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dfaa45bc-6822-4366-87fa-c90d9481d10e	lotto7	368	2020-05-15	{7,8,9,13,21,34,35}	{3,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
225b7723-69b4-4097-8796-8f3955474b7f	lotto7	369	2020-05-22	{1,7,9,11,15,31,34}	{6,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dfbaf664-976d-457c-b3fb-cd2386cf0eef	lotto7	370	2020-05-29	{7,10,16,25,26,33,34}	{24,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a72820df-2d28-49b2-b8ad-001b8df725e5	lotto7	371	2020-06-05	{1,3,4,8,11,21,25}	{12,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
49ddba17-e160-49f5-ac8c-8781954a2ca8	lotto7	372	2020-06-12	{6,8,22,23,32,33,36}	{9,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
31b63dd4-4324-426c-a9a2-2cb2498dc6e5	lotto7	373	2020-06-19	{2,3,17,18,22,23,31}	{4,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
52071cbd-b096-4db2-98db-df88592203ca	lotto7	374	2020-06-26	{4,5,9,10,18,27,35}	{15,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fea71805-bf38-4fb2-a389-b2c288624f25	lotto7	375	2020-07-03	{13,15,18,19,23,27,32}	{34,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
896ee0b3-b6db-48a3-aca3-80c040fa4b68	lotto7	376	2020-07-10	{6,11,14,17,23,31,37}	{10,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
63e2df25-7ed6-4201-b476-d9bf7acb8929	lotto7	377	2020-07-17	{6,7,10,17,25,33,36}	{27,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c4fabe5b-05c7-4e1f-af3f-8c2d79b3088f	lotto7	378	2020-07-24	{1,5,9,10,14,15,29}	{20,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
09831733-0bcc-4650-b9bd-01f68c23acc4	lotto7	379	2020-07-31	{3,8,15,22,24,29,35}	{18,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bcf1fba2-8595-4e4f-939f-b519c48524ac	lotto7	380	2020-08-07	{8,14,24,25,32,34,36}	{13,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d12e19d4-1fac-4309-96c1-b25c795ec3d5	lotto7	381	2020-08-14	{4,8,25,26,27,31,32}	{9,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1d03368f-9ed8-4c9a-9816-8b77f6f31500	lotto7	382	2020-08-21	{2,3,5,8,19,22,37}	{16,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0f6ea17f-5303-4453-b72b-ebcce1ccf2bc	lotto7	383	2020-08-28	{8,11,15,22,26,28,30}	{10,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b9d3955c-3668-45ca-bf91-35316c13c937	lotto7	384	2020-09-04	{3,7,15,18,26,30,31}	{9,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bfe5e1da-0600-4b6a-ad99-dde656385f66	lotto7	385	2020-09-11	{4,12,14,24,29,34,35}	{5,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6693ac1b-63bc-4ae5-857d-c45f4619a6b0	lotto7	386	2020-09-18	{9,19,22,32,35,36,37}	{7,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
34cb22b0-2052-4ce7-af25-85848b69721a	lotto7	387	2020-09-25	{3,7,13,22,30,32,37}	{14,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
481b135b-c9de-41ff-aa6f-5cbfdb9e401f	lotto7	388	2020-10-02	{1,6,8,10,18,21,32}	{13,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2b6eb0ed-c362-4910-aba5-2ad99ee08851	lotto7	389	2020-10-09	{1,6,11,13,18,24,27}	{17,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
579e4288-93a5-4ba2-b0a4-d30b5c31c25e	lotto7	390	2020-10-16	{3,6,19,21,23,26,27}	{30,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9305cb61-0755-4679-8e33-5ac5c897f286	lotto7	391	2020-10-23	{10,23,27,32,33,35,37}	{24,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b1885d1f-c113-41a3-840c-a783c824f567	lotto7	392	2020-10-30	{1,4,6,15,20,22,26}	{18,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e2e41378-5cee-40cc-b24e-805f1ca1f7e9	lotto7	393	2020-11-06	{7,14,15,22,27,30,31}	{9,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
35396959-62bd-4496-a3e7-49da262ec7ae	lotto7	394	2020-11-13	{6,10,22,23,27,32,33}	{8,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7d68f4e0-4976-4884-8a3a-1c2acd0ea94e	lotto7	395	2020-11-20	{1,2,5,20,26,29,32}	{8,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
db089e63-142c-4ec8-a1c9-33b53bd97ff5	lotto7	396	2020-11-27	{2,3,5,8,16,20,34}	{26,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
170ad521-3cc7-4713-b476-b2ebdae791f8	lotto7	397	2020-12-04	{4,12,13,15,21,28,37}	{7,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0a0359bb-00fa-499b-851b-b7366e90c02d	lotto7	398	2020-12-11	{3,4,10,17,20,22,33}	{1,6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
aa3f6b3c-75c7-4631-b680-724ec4722c81	lotto7	399	2020-12-18	{7,15,19,20,21,33,36}	{4,10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f0048185-f88d-42e4-ab6a-4c22c8570399	lotto7	400	2020-12-25	{4,17,22,28,30,31,35}	{25,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bc5e86f1-0926-4e95-9c50-5a191a0d5139	lotto7	401	2021-01-08	{4,5,9,14,18,30,35}	{1,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1251aa98-1960-45b2-b8f9-ba03ef8577ab	lotto7	402	2021-01-15	{7,9,12,17,20,26,29}	{4,13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
36354612-b2fe-4ba3-b3b9-f6494679cdf4	lotto7	403	2021-01-22	{2,6,8,12,19,20,29}	{5,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2c64093b-f75b-4504-beef-b243f301ecbb	lotto7	404	2021-01-29	{4,8,13,16,25,30,32}	{9,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a70d2222-9297-441b-ad81-7f110819cba6	lotto7	405	2021-02-05	{3,10,16,17,24,32,36}	{11,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
db40c4f6-9350-47b1-91bb-2e7cf3e758dc	lotto7	406	2021-02-12	{1,2,5,16,18,21,29}	{24,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
73e999bd-18a1-4707-baef-8f405a0973f4	lotto7	407	2021-02-19	{19,21,25,26,28,30,31}	{9,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
88cb411b-ab0b-47d1-bc7a-a396254b5fa5	lotto7	408	2021-02-26	{16,18,19,21,29,30,35}	{14,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2a3c5fbe-f9b3-45a9-b001-58678d9829d6	lotto7	409	2021-03-05	{13,15,16,24,30,31,37}	{12,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6e4d6ab9-5dfe-4a01-8fbd-6e434a0f515f	lotto7	410	2021-03-12	{1,2,18,21,26,29,37}	{9,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e158b91c-5c79-41d3-9907-3fb5a6734233	lotto7	411	2021-03-19	{4,11,12,21,23,27,36}	{9,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9218ea3d-4051-4231-8297-46ad9343c45a	lotto7	412	2021-03-26	{14,20,22,29,31,33,34}	{15,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7f364de4-424a-4826-8c31-e62cef3e863a	lotto7	413	2021-04-02	{3,10,16,18,19,34,35}	{27,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
57c83078-2cb8-4233-94ec-5b3945088a12	lotto7	414	2021-04-09	{3,8,16,21,25,36,37}	{14,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f84a09a0-6904-4ec5-b5c7-f1b3c015d078	lotto7	415	2021-04-16	{4,8,12,13,23,32,37}	{16,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c73acab5-6648-4594-883c-ceefdd653025	lotto7	416	2021-04-23	{8,9,10,15,16,30,31}	{29,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
73fae881-b5f4-4f27-99b6-17bcb590ae45	lotto7	417	2021-04-30	{4,5,13,18,23,27,32}	{9,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6c7c53d1-7fda-4848-8373-038808c97396	lotto7	418	2021-05-07	{10,13,17,18,22,28,37}	{1,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3f743343-d34a-4689-bcf1-cb0014243e24	lotto7	419	2021-05-14	{3,11,14,21,26,29,34}	{22,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
098d33c9-19da-4d1a-ad2a-29ab3930199f	lotto7	420	2021-05-21	{4,5,11,13,24,32,34}	{2,3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8cb1ef06-7f35-46ed-9d2a-538fd485ecb8	lotto7	421	2021-05-28	{9,15,18,26,28,32,37}	{21,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c629ee13-e207-47b4-9292-ac7108de1a3b	lotto7	422	2021-06-04	{1,9,21,23,30,35,36}	{5,6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c58d25e6-f66e-41f9-85fd-e45ab4601aac	lotto7	423	2021-06-11	{1,7,9,11,29,31,32}	{2,6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2d81c659-3eb0-4bb0-aaca-910bfa291e0b	lotto7	424	2021-06-18	{5,6,12,19,25,30,35}	{26,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
07d381ab-3d1c-489b-adeb-0240b53d849d	lotto7	425	2021-06-25	{2,9,14,20,22,34,35}	{7,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7bc3d850-8f3a-4ef9-9bae-e7cb01037508	lotto7	426	2021-07-02	{1,2,6,8,30,31,33}	{13,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f13916bb-4f7b-4f6c-8f80-4616bfcbb7ce	lotto7	427	2021-07-09	{11,13,26,27,31,33,37}	{9,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
811ac60b-88f7-43fd-a7c9-7b367d493de5	lotto7	428	2021-07-16	{3,6,16,22,31,34,35}	{24,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1652eea9-9728-4ddd-976c-d5335be5cb2f	lotto7	429	2021-07-23	{6,11,14,27,30,32,35}	{18,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
935161e3-4cbb-4b8c-88bd-c7f1753780fc	lotto7	430	2021-07-30	{2,12,17,24,28,30,32}	{3,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8dd22ef5-2a58-40ab-ab75-03ca08df75ff	lotto7	431	2021-08-06	{7,11,12,17,19,20,26}	{2,3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3e97a504-f10a-46be-a90b-ca58abfac690	lotto7	432	2021-08-13	{5,10,13,24,29,30,35}	{21,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3b345c29-c1b1-4868-8d8b-d6ce5c7986b4	lotto7	433	2021-08-20	{14,17,20,25,32,33,36}	{10,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9c3aafd9-5dcd-48bc-8a89-3ee83ef14fac	lotto7	434	2021-08-27	{10,11,12,17,29,34,37}	{26,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6f1453a8-4a20-4255-ab9f-42366f69acfe	lotto7	435	2021-09-03	{3,5,7,11,15,17,25}	{13,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c10de2d5-fae9-4381-acf6-12ba9900b15b	lotto7	436	2021-09-10	{5,6,21,22,26,31,32}	{18,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7665fa00-c755-4fcf-831d-125f34f9605c	lotto7	437	2021-09-17	{8,10,14,15,23,25,26}	{1,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5e0a5592-13da-4acc-a1d1-56923f798fc4	lotto7	438	2021-09-24	{4,13,16,21,32,34,37}	{27,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
afe06391-9ed7-49e9-88b5-c74f20cf1c05	lotto7	439	2021-10-01	{1,3,6,9,26,29,31}	{14,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fe4908cb-02a9-494f-9e54-577b277757db	lotto7	440	2021-10-08	{5,10,17,18,19,22,32}	{14,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8cabd6c9-feae-46f5-8b95-aad9a9da2f35	lotto7	441	2021-10-15	{15,21,22,23,27,28,37}	{8,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fbd3c6b4-80bf-4efb-9390-58161ac52eff	lotto7	442	2021-10-22	{6,13,14,16,19,30,32}	{25,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2463710f-39dd-4530-9e16-76b07e2072ad	lotto7	443	2021-10-29	{1,5,8,26,28,32,36}	{23,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f5f14746-0208-424d-9674-bb669bbd23ec	lotto7	444	2021-11-05	{11,15,16,17,18,27,29}	{25,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
37d318e2-ddec-4a32-bfc0-d4ef08e83bf5	lotto7	445	2021-11-12	{4,22,25,27,28,30,33}	{2,3}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
88849b70-8383-4f06-a412-b96832b8b61e	lotto7	446	2021-11-19	{1,7,9,12,15,29,32}	{11,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
508861c2-111e-4387-b0ce-258136c62192	lotto7	447	2021-11-26	{3,5,8,13,26,30,37}	{25,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a8eb17c9-0f3d-47af-a9b6-7dcb7eda78a6	lotto7	448	2021-12-03	{7,21,24,29,32,36,37}	{22,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
75822f67-e9c0-465c-a691-502845130ed5	lotto7	449	2021-12-10	{2,21,26,27,32,33,34}	{8,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d9be2cab-068a-446b-91bf-91a5ce80ef8a	lotto7	450	2021-12-17	{2,7,12,15,21,23,30}	{9,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1b000b96-3614-4800-9b8d-d4cc19bf8e07	lotto7	451	2021-12-24	{2,15,22,25,28,33,37}	{10,17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5a689099-c6c2-451e-8445-a79657bcce03	lotto7	452	2022-01-07	{5,17,20,21,31,34,35}	{8,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4482ddbb-06e9-434b-b7b1-e48f03a57b6b	lotto7	453	2022-01-14	{2,8,10,21,24,26,35}	{9,13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0b25b05c-ada0-4ed7-bc7f-ace27b450513	lotto7	454	2022-01-21	{8,17,21,26,27,29,31}	{1,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1968f250-6276-4fee-a3aa-0af03d3e77ef	lotto7	455	2022-01-28	{1,5,8,15,18,26,36}	{33,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
41ca4f08-678e-4749-b4e8-7834e29c9536	lotto7	456	2022-02-04	{9,15,17,18,22,25,31}	{33,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0e58c39e-0d30-4260-ab39-38ef6e22cfb1	lotto7	457	2022-02-11	{7,14,19,27,31,35,36}	{9,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
12c74684-7799-47d0-9909-df9a71e423d4	lotto7	458	2022-02-18	{7,11,12,14,19,21,33}	{6,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8d4cd5da-4dec-48ac-9be4-1aeaca386827	lotto7	459	2022-02-25	{2,4,7,8,10,20,29}	{14,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dc786909-5c4e-46f4-96bd-84fbea4ddf35	lotto7	460	2022-03-04	{5,6,9,23,27,28,30}	{4,13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bf29f72e-f9cf-4773-b071-4389560bc079	lotto7	461	2022-03-11	{2,13,19,22,32,35,37}	{14,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a66848ae-d351-4c0b-b03b-bdb451109c5f	lotto7	462	2022-03-18	{7,11,24,27,29,34,35}	{4,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b47303d7-acc6-45d2-be43-54945bd973dd	lotto7	463	2022-03-25	{3,7,13,16,19,24,30}	{6,10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a33ce5c2-aad6-4155-8ef4-7ab118ebf3e3	lotto7	464	2022-04-01	{7,8,13,17,30,32,36}	{1,10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7851e5ef-b551-40e6-8243-815780fb7e8e	lotto7	465	2022-04-08	{1,4,5,13,27,31,35}	{15,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4bde2562-416b-49bd-8002-307312f43fbf	lotto7	466	2022-04-15	{5,6,8,14,15,25,29}	{18,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8aedb7bb-10e5-43ce-b69e-5575201200b4	lotto7	467	2022-04-22	{7,8,11,13,14,26,30}	{31,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2c2c6bac-2fb2-46e0-842e-d35eb577e6dc	lotto7	468	2022-04-29	{3,12,15,16,25,29,37}	{26,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
227eab1f-cb1d-4012-8744-763cda9b35ae	lotto7	469	2022-05-06	{1,6,8,13,16,30,33}	{23,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3440c505-058e-4170-9457-f3509494bcc8	lotto7	470	2022-05-13	{2,3,9,16,27,32,36}	{1,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9da61b8d-7196-49b4-96f1-f68d44dd2686	lotto7	471	2022-05-20	{3,5,7,8,11,19,34}	{17,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a354f793-5d5f-4f1f-90cb-160ce8f91ac5	lotto7	472	2022-05-27	{5,7,8,32,33,34,36}	{4,6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3e4ab870-801d-45af-92f4-0658b8624e08	lotto7	473	2022-06-03	{6,11,21,24,28,33,37}	{8,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c145035b-13b1-4cd3-8c44-20127b25c655	lotto7	474	2022-06-10	{3,17,19,21,24,32,34}	{27,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c5e68c12-2db5-4a24-b9a3-920e2a17d702	lotto7	475	2022-06-17	{1,2,22,24,26,31,37}	{12,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
18a3ade4-bb49-4aa1-9e2a-1d0f961673fa	lotto7	476	2022-06-24	{4,7,9,15,22,24,31}	{21,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d409639a-16e6-43be-ba6d-78c781f16823	lotto7	477	2022-07-01	{2,5,9,19,25,32,37}	{7,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f47f6174-6f1d-475c-919e-3920c017c8dc	lotto7	478	2022-07-08	{6,8,11,13,16,20,32}	{12,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
93d35f2e-5246-45ad-89d7-b89654a480fa	lotto7	479	2022-07-15	{8,11,13,18,24,30,31}	{21,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
cf099300-802f-4283-90a4-6ea78bc3b710	lotto7	480	2022-07-22	{10,13,19,21,26,30,36}	{22,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0055c224-18dc-4576-89ef-9c210d2b6f7b	lotto7	481	2022-07-29	{1,10,13,14,16,25,27}	{5,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1454e987-9ca5-48c4-9c85-0430fed961fa	lotto7	482	2022-08-05	{2,5,14,15,17,19,36}	{8,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4b65d944-aa04-4226-8650-33bf5a52baf4	lotto7	483	2022-08-12	{2,11,20,23,25,36,37}	{29,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
500282e0-b252-40fa-be2d-5ccdd7465bed	lotto7	484	2022-08-19	{1,4,6,9,13,22,31}	{29,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5044923f-24f8-4b78-a4b8-ecf480875514	lotto7	485	2022-08-26	{4,6,17,20,22,24,26}	{8,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7cdab58d-d940-4fda-b8e8-ac427abfb0af	lotto7	486	2022-09-02	{8,13,15,23,24,31,35}	{14,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8b977e07-7c64-4d84-8a21-759a690ccb35	lotto7	487	2022-09-09	{9,10,13,15,26,34,37}	{22,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1cdf7970-f259-490a-bdc9-def98121f1b8	lotto7	488	2022-09-16	{3,13,16,18,19,20,35}	{2,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d151d88c-60c9-4e14-9920-e85b98eaed5f	lotto7	489	2022-09-23	{3,6,7,15,25,29,31}	{8,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1c67ed16-54dd-4a36-b21c-cfb7d4e5db7e	lotto7	490	2022-09-30	{12,14,18,21,23,29,37}	{7,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
01c1dc5c-71ad-4047-be24-01a37f3bc771	lotto7	491	2022-10-07	{3,14,17,21,22,32,35}	{6,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c8412c54-9246-40cf-a936-3853e29b5ff5	lotto7	492	2022-10-14	{7,10,12,15,23,31,37}	{9,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3f9811a8-2dc9-4035-8fb4-f19ba9a153fb	lotto7	493	2022-10-21	{5,13,14,20,21,25,31}	{9,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d9576693-206e-4c8b-a36d-77b8deba6234	lotto7	494	2022-10-28	{7,9,12,22,28,29,32}	{17,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1fd72f90-020b-4bae-b048-4aeb83f9f878	lotto7	495	2022-11-04	{2,16,19,20,22,33,36}	{6,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6e884b7f-1e71-4e0d-8986-1bf3feca1760	lotto7	496	2022-11-11	{5,8,15,18,25,27,36}	{10,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e3345f47-46e4-47f0-8161-587cf4e04a09	lotto7	497	2022-11-18	{18,20,24,26,27,30,33}	{17,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
90639e3b-2096-4656-acbc-05f9e01321bb	lotto7	498	2022-11-25	{6,8,12,20,21,24,29}	{4,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ffc7eb47-efc7-4375-9936-72584dcaac29	lotto7	499	2022-12-02	{5,9,14,18,27,32,34}	{6,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d612ac8c-888b-4a74-ac60-cf2b5ab125f0	lotto7	500	2022-12-09	{17,18,24,30,31,32,35}	{6,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
59e26455-27df-477d-87f0-65cef2b0e683	lotto7	501	2022-12-16	{1,2,4,7,12,14,31}	{30,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
22befbe0-c19b-40f7-8b33-73893e7fd5db	lotto7	502	2022-12-23	{1,2,12,17,21,22,33}	{4,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a8ee133b-fe98-45f3-87c0-c59ca0fbfb2d	lotto7	503	2022-12-30	{5,7,8,13,23,26,33}	{31,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
37823356-bcbd-4c96-a99a-79a03a93e0a6	lotto7	504	2023-01-06	{1,3,4,5,6,29,31}	{11,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3516fd31-7c28-4aea-b41b-80bbcaa490a4	lotto7	505	2023-01-13	{9,10,12,15,16,28,36}	{1,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dc81ef65-299a-44a4-81a6-09cba023fac1	lotto7	506	2023-01-20	{8,14,19,22,29,31,37}	{3,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c1f0bf4e-40e8-4acf-afed-0e2de6e05077	lotto7	507	2023-01-27	{4,19,25,26,30,32,36}	{1,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
83ff1aa0-8b40-46eb-b82b-d43469beee90	lotto7	508	2023-02-03	{1,5,6,9,16,26,31}	{25,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
35020120-33cf-4ddb-9365-8e19d88a687f	lotto7	509	2023-02-10	{10,14,22,26,27,32,33}	{20,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
404e44f1-7e75-4026-9c20-a6603c2e7693	lotto7	510	2023-02-17	{3,5,9,11,17,33,37}	{4,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
771737cc-ba5a-40ad-bc87-d2a3738296b9	lotto7	511	2023-02-24	{1,9,14,24,28,36,37}	{16,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
227aae9f-7eae-43f6-8ef0-aa4f6fb9930f	lotto7	512	2023-03-03	{5,7,17,22,25,26,28}	{3,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fb7c8641-f49d-4588-a7ff-2d03ad559acb	lotto7	513	2023-03-10	{1,4,10,13,15,19,37}	{16,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e0ec81f2-4a71-4a3f-a2af-1cec430ab693	lotto7	514	2023-03-17	{1,5,10,17,20,27,37}	{3,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b513ebaa-babb-4a08-bbc3-cff17b180d2e	lotto7	515	2023-03-24	{3,15,17,22,26,27,28}	{6,8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a5403f34-e088-4080-8b28-b8ca49ae9b6d	lotto7	516	2023-03-31	{7,12,15,16,18,25,36}	{9,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
adf19fbb-028a-4f67-91b8-6734c5e902ae	lotto7	517	2023-04-07	{3,6,10,16,26,29,31}	{7,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3dcf2d6c-e763-4844-bf2e-c822709c2567	lotto7	518	2023-04-14	{5,8,11,24,30,32,36}	{4,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
22cf4a14-1bf6-4f10-be3d-8d74bb453d5f	lotto7	519	2023-04-21	{1,2,8,14,17,21,34}	{20,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d5d828f0-28d0-4aae-b217-4d1fb0df68b3	lotto7	520	2023-04-28	{9,22,25,28,33,34,37}	{15,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
959ea121-f25a-4df6-a4fc-ac38b2b7b2ad	lotto7	521	2023-05-05	{21,24,25,27,30,33,36}	{3,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e9fd072d-16da-41ae-a829-bc3711fc5faf	lotto7	522	2023-05-12	{1,10,12,19,22,25,37}	{2,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
506a9808-6307-4877-878c-7f8872f3ce67	lotto7	523	2023-05-19	{3,17,19,27,28,32,35}	{2,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7688768f-b656-49cc-bac1-831b52dbeb13	lotto7	524	2023-05-26	{4,17,22,27,29,31,34}	{3,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7478f131-609a-4df8-bde9-32a7c0bd2f5f	lotto7	525	2023-06-02	{11,14,17,18,21,25,31}	{1,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e770da0c-81fc-443e-ae21-9f0a0aa70874	lotto7	526	2023-06-09	{4,13,17,19,20,26,29}	{2,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d9c1ac1d-0b6b-4957-aebc-713520f27a22	lotto7	527	2023-06-16	{4,8,12,25,27,32,34}	{15,17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
55733b12-6e7e-46e0-a890-f522c1264bae	lotto7	528	2023-06-23	{5,7,10,19,30,32,33}	{1,17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e8e1d8b3-4b5e-4b63-8b51-59175d2931c6	lotto7	529	2023-06-30	{7,9,13,14,22,26,29}	{10,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
92e1ba80-9094-4a86-95e4-c621a670d63e	lotto7	530	2023-07-07	{1,11,13,28,29,30,34}	{23,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
cc3ef4f9-5372-46e7-b11e-d75c7627c73d	lotto7	531	2023-07-14	{4,6,9,11,14,28,30}	{10,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
42dd9697-7195-4c57-a441-918544ef1862	lotto7	532	2023-07-21	{4,9,13,18,26,28,36}	{8,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
73b284b7-483a-49cf-8ee5-8854780446cb	lotto7	533	2023-07-28	{2,4,9,11,14,25,37}	{29,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
21476e3a-19ba-4ca1-b064-7529aece3327	lotto7	534	2023-08-04	{10,17,18,19,20,24,25}	{30,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b9b06049-79fd-41a1-bc00-4f77d11ade14	lotto7	535	2023-08-11	{5,11,12,19,29,32,36}	{9,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fb3908a7-958a-4e32-a05f-5576bf14379c	lotto7	536	2023-08-18	{8,12,16,17,22,28,34}	{9,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a5dce855-2330-4d10-b437-92c216a25003	lotto7	537	2023-08-25	{2,3,9,13,14,35,37}	{4,17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b9a73ea4-1104-483e-bf99-95c278db779b	lotto7	538	2023-09-01	{1,2,11,12,16,25,28}	{6,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3881a20c-300f-43d8-bcf4-d03cbe6c0f9f	lotto7	539	2023-09-08	{4,6,8,18,20,27,35}	{24,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4f976752-fe62-49e4-bcf2-40e48c77972e	lotto7	540	2023-09-15	{3,7,10,18,19,28,36}	{13,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
974dfd45-209c-41e0-9e40-77a561c70b60	lotto7	541	2023-09-22	{6,14,23,25,27,28,34}	{19,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6ae98eb1-ef48-499c-89e4-a3100ea036d3	lotto7	542	2023-09-29	{2,9,26,31,33,35,36}	{15,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bdd120eb-ec9d-431d-b2e5-ee85733b258e	lotto7	543	2023-10-06	{2,11,13,18,23,24,36}	{17,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
818d4b5d-1f78-49c0-9cf3-d4e5c2bcfa61	lotto7	544	2023-10-13	{10,11,18,21,22,29,34}	{4,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9760a017-ee6f-47b4-a531-0a86bff26892	lotto7	545	2023-10-20	{3,12,16,17,27,30,34}	{15,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4dba36eb-8a2c-4226-ad26-2299e3b5b2cb	lotto7	546	2023-10-27	{7,14,17,28,33,35,36}	{13,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
394d4114-653c-4cb7-945d-6974c613f56e	lotto7	547	2023-11-03	{4,11,14,18,23,25,29}	{17,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4ed2b838-a4e2-414b-9fda-3e5f8925f8f3	lotto7	548	2023-11-10	{1,13,16,17,18,25,30}	{20,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8666c0e1-ece9-4782-9c64-14d4eb4a034a	lotto7	549	2023-11-17	{13,19,20,28,33,34,35}	{4,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f5dcd638-de4b-4677-89c0-8227e6d874ec	lotto7	550	2023-11-24	{7,8,13,22,24,29,30}	{10,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9b655b8b-703d-4da5-ac37-70648d62556d	lotto7	551	2023-12-01	{15,16,17,22,29,32,37}	{23,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
398606e5-519a-47de-acdd-bf1abbfb2be3	lotto7	552	2023-12-08	{7,11,12,16,18,33,34}	{1,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b634e8b0-070f-4e1c-9c56-45afe2074f1c	lotto7	553	2023-12-15	{2,6,13,15,16,20,33}	{9,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
fd55ba3a-a674-4c85-a9ec-68ad2a1492e2	lotto7	554	2023-12-22	{4,10,15,17,29,32,36}	{13,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2a85df60-a2ce-4af4-82d7-caec0f3233fd	lotto7	555	2023-12-29	{9,12,17,19,26,32,34}	{11,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
03334027-8a26-4e81-a6c2-59026ed293bc	lotto7	556	2024-01-05	{17,20,26,28,29,33,35}	{1,6}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
cd14ed65-1882-4004-9582-57204924a554	lotto7	557	2024-01-12	{3,5,7,10,17,18,35}	{2,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
01885703-1510-4a97-a38d-934c5857f94e	lotto7	558	2024-01-19	{15,20,21,22,23,26,34}	{6,10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
211113e8-5179-487d-b5c1-997fcdefe1fa	lotto7	559	2024-01-26	{3,4,10,13,15,18,22}	{2,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c8d77e46-d78d-44e1-b1ba-17835c49f20f	lotto7	560	2024-02-02	{3,20,29,32,33,34,35}	{2,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1079da50-d38b-4142-a311-f42140ba0614	lotto7	561	2024-02-09	{6,8,19,20,27,32,37}	{13,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f9c7c8d9-fc99-4a85-a9a9-b32869dc0a61	lotto7	562	2024-02-16	{2,14,15,20,28,30,34}	{3,4}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c4917695-2e36-4566-a9cf-a7d1cbf1866c	lotto7	563	2024-02-23	{1,4,6,14,16,19,31}	{12,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6e9d4c25-9a61-484f-b682-97261c5d09ae	lotto7	564	2024-03-01	{9,13,15,18,22,24,30}	{6,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
07b3df81-dbf8-416f-b1cd-dcb6fb9acea7	lotto7	565	2024-03-08	{3,6,9,11,19,30,36}	{1,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d7ed40d2-f45e-436e-8e77-229b4234ae19	lotto7	566	2024-03-15	{3,5,18,25,28,35,37}	{7,8}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2eddd93a-71e2-4eb0-9067-1d93271b836f	lotto7	567	2024-03-22	{6,8,16,18,19,34,37}	{15,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b7fa1ed7-b0b6-4ac8-b8dc-7ca8e69f8aed	lotto7	568	2024-03-29	{8,18,20,29,30,33,34}	{5,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9b54d3ee-e772-42eb-bf0d-b9be94156aab	lotto7	569	2024-04-05	{12,15,17,22,30,34,35}	{5,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2dfbcbc2-894a-4751-a0dc-3c67165ac5b4	lotto7	570	2024-04-12	{1,3,9,12,25,26,35}	{29,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5376e9b0-551e-4bdc-9d65-95796c6389e3	lotto7	571	2024-04-19	{13,26,27,29,30,34,37}	{2,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b274139a-53d9-418d-b0b3-0984727d7a05	lotto7	572	2024-04-26	{1,2,4,19,21,26,28}	{3,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2de3632d-51bd-4659-8262-25359d654a60	lotto7	573	2024-05-03	{11,12,18,19,23,26,31}	{15,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
994f89b1-b50e-4dc6-9708-43fc143bbf0b	lotto7	574	2024-05-10	{4,5,13,16,22,23,35}	{36,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a9768677-217e-486e-90cd-29441801eebb	lotto7	575	2024-05-17	{2,12,18,20,25,28,30}	{9,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
60d84c1d-4879-4ae9-8a3f-068dce9fccaa	lotto7	576	2024-05-24	{11,13,14,18,19,23,31}	{7,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
be2dcd55-36e2-4191-b0a5-1027d3e28768	lotto7	577	2024-05-31	{11,13,19,25,29,36,37}	{18,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5449d547-eb18-4a1b-b1bd-2220b6b8e986	lotto7	578	2024-06-07	{2,15,19,20,22,31,36}	{13,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
23308a3c-1bf5-4a54-a7da-6a366dcaf491	lotto7	579	2024-06-14	{7,19,23,33,34,35,36}	{5,10}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7584172d-65ff-4aaa-9457-845909f1650e	lotto7	580	2024-06-21	{4,13,14,15,17,27,33}	{2,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1b69997c-3d0b-4d4e-a199-c74016cd3f3d	lotto7	581	2024-06-28	{3,8,10,15,18,23,37}	{17,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ed17fcf1-49b1-46d8-b6ce-c7ec31f5b8c6	lotto7	582	2024-07-05	{5,7,22,29,30,32,36}	{3,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
19977eaa-8f24-4037-a0b0-5fe1cd9d0711	lotto7	583	2024-07-12	{1,5,8,9,20,30,37}	{11,26}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b53eb63f-e4c4-4c82-89e3-a3ca2ec5fa49	lotto7	584	2024-07-19	{10,11,12,17,23,30,36}	{20,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2e55f151-6775-42e6-83a4-94b54b822684	lotto7	585	2024-07-26	{6,11,13,14,16,27,34}	{12,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
82c860e6-e67a-448c-9a3c-4d91f322786f	lotto7	586	2024-08-02	{1,2,4,14,15,22,23}	{13,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f4b5682c-e3bd-4d36-a104-0bc7c105ad46	lotto7	587	2024-08-09	{15,18,21,22,23,25,32}	{1,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e6018281-ce07-47e6-bc76-e33139092516	lotto7	588	2024-08-16	{3,5,9,13,15,21,31}	{12,17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
39a44d45-795c-45b2-9e3c-f526dda56c91	lotto7	589	2024-08-23	{1,6,8,9,14,29,33}	{5,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b97cddc7-885b-4dde-a936-db056df9d911	lotto7	590	2024-08-30	{1,3,9,10,15,25,35}	{19,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ac41cf8b-aa5a-4746-96d1-606d8e3290ca	lotto7	591	2024-09-06	{4,7,8,11,21,23,35}	{10,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b2074216-d9a6-4be8-bdd7-1916fdf98a02	lotto7	592	2024-09-13	{3,8,11,15,19,24,32}	{14,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bf13bb40-d21c-4176-8d69-2a3c9b456414	lotto7	593	2024-09-20	{3,8,9,14,15,22,32}	{1,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
eade8d58-4b02-4352-9ce3-4aa8e1d03af2	lotto7	594	2024-09-27	{5,12,21,25,27,34,36}	{10,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
41c8227a-b89a-43ca-888b-32dd6218f7d3	lotto7	595	2024-10-04	{14,15,16,19,25,28,33}	{6,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6dc041d5-f0c8-4317-8c42-f4d1d3399524	lotto7	596	2024-10-11	{1,9,16,19,23,29,32}	{5,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f4455350-e4b4-4ee8-8d85-75689097f9a5	lotto7	597	2024-10-18	{2,4,14,15,22,27,34}	{1,5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4ed0eac1-9d1b-4d09-9b5e-98bf77840efa	lotto7	598	2024-10-25	{1,4,7,11,12,18,26}	{3,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
81d6cc81-bc81-4831-83ad-d0e1e03e9a55	lotto7	599	2024-11-01	{4,7,16,19,26,31,33}	{25,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bccc99dd-75da-4ffb-8cf8-6944917c2b17	lotto7	600	2024-11-08	{1,2,12,16,19,29,32}	{9,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
abaef2bc-98a4-4110-a586-417c3147a289	lotto7	601	2024-11-15	{4,8,18,20,29,35,37}	{19,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1aaf5aaf-1ace-488a-bf7c-1fad497a7aa9	lotto7	602	2024-11-22	{7,15,18,24,29,31,34}	{5,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
cd7c1fe8-a1ca-45f0-8fb5-01f499d9c678	lotto7	603	2024-11-29	{4,9,10,23,28,30,34}	{18,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2f0139d4-6a91-4098-b3a2-108d26d6f55a	lotto7	604	2024-12-06	{4,6,9,12,25,31,36}	{27,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
152da936-34dd-490b-b0cd-b37eccf2c04f	lotto7	605	2024-12-13	{2,8,15,26,28,31,32}	{19,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2625baf9-40e8-46e8-8b8b-a88c334458c1	lotto7	606	2024-12-20	{9,17,18,20,22,27,36}	{25,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1e041ae9-c91c-49a7-a29e-91b7d3110891	lotto7	607	2024-12-27	{12,14,20,27,31,34,37}	{19,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dd1ffdaf-ea1f-4aa2-a207-de4d0b504250	lotto7	608	2025-01-10	{7,10,11,18,20,29,30}	{32,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
70a08933-36cf-478c-b437-618bfe6b99dc	lotto7	609	2025-01-17	{4,11,12,23,26,32,37}	{1,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0a3baeb1-b9ab-4a71-b70d-44bcf16dfd01	lotto7	610	2025-01-24	{1,8,9,23,24,31,36}	{21,28}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
83d682e6-a964-4f1e-8473-2fdbe2878000	lotto7	611	2025-01-31	{7,8,11,18,20,30,34}	{5,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f537f932-1ba9-4cf3-b8d1-83db091277d8	lotto7	612	2025-02-07	{5,13,16,23,27,31,34}	{26,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c98d6b12-9fd2-429e-b415-726bf9a150ad	lotto7	613	2025-02-14	{3,5,6,10,19,21,35}	{13,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
be7718ec-014b-4845-92d5-13349a7bc916	lotto7	614	2025-02-21	{14,21,22,23,24,28,34}	{5,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6d856034-bf76-4477-8a72-f71b5f162371	lotto7	615	2025-02-28	{4,11,21,26,27,28,33}	{10,13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d8f332ba-1ca6-494f-b98c-74ca16d2f1c6	lotto7	616	2025-03-07	{7,15,20,28,29,34,36}	{1,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ca9169dc-89ee-45f2-b67b-34d0e55efea4	lotto7	617	2025-03-14	{2,6,10,12,25,28,35}	{27,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
26dfc601-1071-4e1d-b0c2-c3095b0451be	lotto7	618	2025-03-21	{7,17,20,23,24,34,36}	{25,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b87a73eb-3ad7-4045-abc2-5662e8fb4576	lotto7	619	2025-03-28	{8,9,18,20,27,29,32}	{7,12}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
72666cfd-06e8-46e4-bb49-5d2d2cc6f1b7	lotto7	620	2025-04-04	{2,4,8,10,12,29,32}	{6,13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d7643beb-807c-445f-a4be-becec5f2da01	lotto7	621	2025-04-11	{1,2,12,13,14,30,36}	{9,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0ff1b323-b959-4e2c-b047-3913a104f166	lotto7	622	2025-04-18	{1,10,28,29,30,33,34}	{21,27}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f3191f56-6979-4247-b73f-008b6d2270fb	lotto7	623	2025-04-25	{9,12,22,26,28,31,37}	{7,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1393a399-2d9e-426f-8676-ee7773609b38	lotto7	624	2025-05-02	{2,14,15,26,27,34,36}	{9,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
4b5b4523-0f0b-44bb-8638-150ec9d59261	lotto7	625	2025-05-09	{3,10,12,18,19,24,32}	{4,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
87515fd3-5909-45ef-a1fe-47dd3401134e	lotto7	626	2025-05-16	{1,3,7,12,17,32,34}	{14,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
74a29a58-717c-4150-b795-ea2961baadb2	lotto7	627	2025-05-23	{9,15,21,30,33,34,37}	{10,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5ce31bef-4ac3-452a-bd1f-df10e66f00fe	lotto7	628	2025-05-30	{1,8,9,11,18,27,35}	{16,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ca97853e-8b0e-4cd2-91f9-cca3d6854538	lotto7	629	2025-06-06	{2,7,9,21,23,24,30}	{22,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7f722dd0-875a-4a6e-9a38-6bc2aecba71e	lotto7	630	2025-06-13	{4,6,8,23,28,29,34}	{10,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c1d43491-bd86-48ec-8219-46c6a60cfd43	lotto7	631	2025-06-20	{2,3,6,17,33,35,36}	{25,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e418723b-f7c8-473d-9d81-757a63618741	lotto7	632	2025-06-27	{5,7,10,11,29,31,37}	{13,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f9cb0340-28c6-47a1-a2f8-750f1eb01d28	lotto7	633	2025-07-04	{2,5,10,17,21,31,36}	{20,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
85eba24d-985e-4fb1-806e-480666405ab4	lotto7	634	2025-07-11	{2,12,18,29,32,36,37}	{6,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1ca26e7e-dfdf-4b80-bcee-1b816c955302	lotto7	635	2025-07-18	{10,12,20,29,30,31,34}	{4,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
00bf2e8f-8110-44eb-8f4b-c85bd412eef2	lotto7	636	2025-07-25	{10,14,17,20,26,27,29}	{3,11}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
17b00f9c-aa86-42c3-8947-80b65f5a9e3f	lotto7	637	2025-08-01	{1,4,7,8,9,20,21}	{11,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
deeebfa2-d120-446f-89f6-86bdec85ff40	lotto7	638	2025-08-08	{1,6,18,19,35,36,37}	{11,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e94b88e9-89b0-4b12-9687-d2885bdf9032	lotto7	639	2025-08-15	{5,9,12,15,30,31,34}	{13,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
2603ff88-a46e-45c3-af50-382008cd9799	lotto7	640	2025-08-22	{2,7,9,12,13,14,29}	{15,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0cc36297-84dd-4e7b-bb45-89e6a0a6160b	lotto7	641	2025-08-29	{1,3,7,23,24,33,36}	{17,30}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
baae21d9-63fb-468d-a2ea-4b6681ac0905	lotto7	642	2025-09-05	{1,7,22,23,33,34,35}	{2,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0065d5a0-329c-433b-a392-b445b60f4ac1	lotto7	643	2025-09-12	{1,5,15,16,18,27,34}	{19,22}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7ee3a564-9a85-48bc-89fb-ed4fa7e9fead	lotto7	644	2025-09-19	{1,11,12,14,20,26,29}	{2,5}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
999e824d-2439-424f-906e-5f7944d1138a	lotto7	645	2025-09-26	{7,10,16,20,26,32,35}	{24,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
0881c322-c73c-4d78-9ff2-962b023680fe	lotto7	646	2025-10-03	{5,12,13,15,18,35,37}	{11,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
023e4790-fe35-4308-b441-d799514c7d43	lotto7	647	2025-10-10	{4,5,9,13,17,22,28}	{18,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b60b6365-c600-4b44-b807-b434e18ae8bb	lotto7	648	2025-10-17	{3,17,19,24,28,29,35}	{7,13}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
348f51a6-6a41-4990-8d21-9ecdcdd94c8b	lotto7	649	2025-10-24	{12,22,23,26,33,35,37}	{2,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
ca3d08db-94ca-48ca-8af3-f127ac41ffb4	lotto7	650	2025-10-31	{1,8,10,14,25,33,35}	{12,21}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a84cf480-4efa-4561-99a9-fe34b57221ed	lotto7	651	2025-11-07	{2,13,19,20,24,26,35}	{29,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
efb421d2-d4bb-45e9-a8fe-f55cd9989651	lotto7	652	2025-11-14	{1,16,21,26,27,30,35}	{6,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1efe462b-fc18-4e77-a932-e883986aa6e5	lotto7	653	2025-11-21	{6,7,12,25,26,30,33}	{13,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
dd17e0b2-7efe-4587-a41d-259d7933bc13	lotto7	654	2025-11-28	{3,12,25,29,30,32,33}	{28,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9cfc7365-79da-47db-b7ba-4bd1c5de5851	lotto7	655	2025-12-05	{4,5,12,13,24,26,33}	{3,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7f408171-0dfa-4901-8201-5634f487ae26	lotto7	656	2025-12-12	{1,4,6,20,30,34,37}	{14,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
20badc4d-4eca-4ac2-bcf1-1c4f885f9b91	lotto7	657	2025-12-19	{9,11,16,23,27,29,32}	{6,24}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
946cb295-4551-4916-b2b6-240f60f0f07a	lotto7	658	2025-12-26	{10,12,16,18,19,22,37}	{11,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
6007c2b1-2b2a-4eb0-bda2-94ca1b94758a	lotto7	659	2026-01-09	{2,8,9,14,27,34,36}	{5,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
64b75c45-2872-4738-a278-95d1ec985e11	lotto7	660	2026-01-16	{4,6,12,13,16,17,31}	{14,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8b1f600f-fc3d-4a07-96e8-da598070e46d	lotto7	661	2026-01-23	{7,12,17,22,31,34,35}	{20,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c4bee6b3-3de4-42b4-aa8c-6347a171e7ca	lotto7	662	2026-01-30	{4,14,15,21,22,24,37}	{5,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
8ab0c319-8b02-487b-9851-3130cd9f1b04	lotto7	663	2026-02-06	{4,6,10,11,13,17,23}	{26,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b4a22911-7bee-4cf2-a129-b6876be91b6e	lotto7	664	2026-02-13	{3,6,8,14,21,22,31}	{17,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
d4e80b96-1e1b-4fb2-b3fb-9a9ecf73db56	lotto7	665	2026-02-20	{6,8,14,19,22,25,35}	{12,17}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
bc74e0e0-4f2f-48e2-a5c8-dc43ffb28251	lotto7	666	2026-02-27	{2,17,18,22,23,25,33}	{16,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e11b680d-874b-4c24-a8bc-b5547243cbc5	lotto7	667	2026-03-06	{9,13,20,22,28,29,33}	{21,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
07bde3ea-7423-48f1-90df-ad2d107e6830	lotto7	668	2026-03-13	{1,8,11,14,18,22,29}	{19,35}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9b1a0ac7-e4b2-429f-8269-53becde749e5	lotto7	669	2026-03-20	{3,5,6,7,9,13,16}	{11,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
05338140-c8fe-4446-b6b9-1e1c23ebe1e0	lotto7	670	2026-03-27	{3,4,9,10,18,21,37}	{15,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
3cb0bae9-e9cf-4ef1-89f3-9ece1c0e0059	lotto7	671	2026-04-03	{7,13,16,22,28,33,36}	{2,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1d987299-362c-4b06-88aa-3de828662c91	lotto7	672	2026-04-10	{7,11,15,16,17,24,33}	{6,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
02d659fa-8056-40d7-a89a-42b4fd978057	lotto7	673	2026-04-17	{6,9,10,12,16,24,32}	{17,19}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e08fca28-00a8-4cbe-918c-c14116e76676	lotto7	674	2026-04-24	{1,6,7,9,12,22,26}	{8,14}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a53e3ba9-76ca-4b82-ba4c-6e84c3f967d9	lotto7	675	2026-05-01	{5,8,16,18,24,28,31}	{6,23}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
be044330-0cf5-46d2-9f86-11b75f3ee8a3	lotto7	676	2026-05-08	{2,6,15,19,20,22,27}	{31,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
96513249-2b2d-4378-b98d-0c9d65480d13	lotto7	677	2026-05-15	{5,6,7,8,15,17,19}	{1,33}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
f049cbfc-6567-442c-976b-a991cae82662	lotto7	678	2026-05-22	{2,6,12,15,24,26,34}	{18,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a7af2e37-91cd-449b-83ce-ea07d9811b95	lotto7	679	2026-05-29	{6,8,9,18,22,24,35}	{4,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
1acdcde9-d85e-409d-99e5-1b97e49889b1	lotto7	680	2026-06-05	{9,10,22,26,27,31,36}	{20,29}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
5f8b5d60-f4a9-498b-9687-f6f9932fc13a	lotto7	681	2026-06-12	{1,10,12,13,19,33,35}	{14,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7496415f-afa4-404f-965f-8b625cdf7e1b	lotto7	682	2026-06-19	{11,14,17,23,28,30,36}	{12,20}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
a3d77bda-0612-43c7-91a9-02cada76037a	lotto7	683	2026-06-26	{11,21,22,25,28,29,36}	{8,32}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
472c10c2-58b6-4bbf-9e22-e295208fc8a6	lotto7	684	2026-07-03	{8,14,17,19,20,32,36}	{21,25}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
579e7ffa-2869-4c68-ab08-fa9f9cfafa66	lotto7	685	2026-07-10	{1,5,16,20,21,22,31}	{23,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
9cae925c-66bf-4035-8c38-7cd6af435b0d	lotto7	686	2026-07-17	{1,3,16,18,32,34,35}	{2,15}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
b7a60388-b925-4a6e-acf6-dee9f3c8802e	lotto7	687	2026-07-24	{15,22,23,24,25,29,36}	{35,37}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
db98eb65-25a5-4265-8f97-86109eac4513	lotto7	688	2026-07-31	{4,21,25,28,30,35,37}	{12,16}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
cb572f13-fd9c-4604-95b6-e37934b86115	lotto7	689	2026-08-07	{4,18,23,24,32,33,35}	{29,36}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
e31e8814-8b44-491d-b2c2-088c275fa295	lotto7	690	2026-08-14	{3,10,14,17,18,20,25}	{19,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
da0ed797-aa17-41ea-8ec8-a365fa7ed7d0	lotto7	691	2026-08-21	{8,10,20,22,23,27,37}	{2,9}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7cc5b453-a4e6-4878-b2df-00bae781d3ab	lotto7	692	2026-08-28	{7,9,15,18,20,28,31}	{21,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
06c32168-d26c-418c-8546-510ef6a837f2	lotto7	693	2026-09-04	{16,17,22,23,25,33,35}	{13,31}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
32f7e255-47e3-45dd-9596-5e41cd7ae605	lotto7	694	2026-09-11	{3,13,24,26,30,31,36}	{23,34}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
c9f22b25-ef26-4b05-8b82-b4a89b40eded	lotto7	695	2026-09-18	{5,6,11,16,22,24,34}	{15,18}	\N	t	2026-09-21 15:34:37.842477+00	2026-09-30 12:10:55.592647+00
7b9b13e2-9a43-4a64-9b01-663656f4347f	lotto6	2139	2026-09-21	{3,6,23,34,36,43}	{29}	\N	t	2026-10-01 15:48:50.56284+00	2026-10-01 15:48:50.56284+00
b5cf23c6-76c2-44ce-b9e5-7bada5df8b4f	lotto6	2140	2026-09-24	{4,10,11,19,21,33}	{30}	\N	t	2026-10-07 03:28:38.205606+00	2026-10-07 03:28:38.205606+00
b98e92bb-96ba-496d-b2bf-d2886fee0c52	lotto6	2141	2026-09-28	{14,15,22,32,37,41}	{1}	\N	t	2026-10-07 03:28:38.205606+00	2026-10-07 03:28:38.205606+00
270d52bc-ebb6-4358-9ea8-98183c24e6d8	lotto6	2142	2026-10-01	{2,14,20,21,31,39}	{36}	\N	t	2026-10-07 03:28:38.205606+00	2026-10-07 03:28:38.205606+00
f130bab1-d5f7-41d6-8166-1b52cf340b5b	lotto6	2143	2026-10-05	{1,7,8,29,40,43}	{15}	\N	t	2026-10-07 03:28:38.205606+00	2026-10-07 03:28:38.205606+00
8c17c7b1-d13b-42e3-8ec3-efe80ec4b58b	lotto7	696	2026-09-25	{10,11,15,16,23,24,34}	{14,35}	\N	t	2026-10-07 03:28:38.205606+00	2026-10-07 03:28:38.205606+00
e948619a-bb25-43cb-80f8-84a8bddeae21	lotto7	697	2026-10-02	{1,6,12,23,28,32,36}	{31,34}	\N	t	2026-10-07 03:28:38.205606+00	2026-10-07 03:28:38.205606+00
141253ed-a125-4ae4-8e15-c3ebdd7c4932	lotto6	2144	2026-10-08	{5,6,11,25,31,32}	{15}	\N	t	2026-10-14 22:48:10.143141+00	2026-10-14 22:48:10.143141+00
50bc58c8-e6f8-4461-9958-9480e67e89b4	lotto6	2145	2026-10-12	{4,6,8,11,24,27}	{36}	\N	t	2026-10-14 22:48:10.143141+00	2026-10-14 22:48:10.143141+00
e5fe5eb4-aa28-4d4c-8f8d-f7d499ec5fe7	lotto7	698	2026-10-09	{10,13,21,24,28,29,34}	{1,26}	\N	t	2026-10-14 22:48:10.143141+00	2026-10-14 22:50:45.781612+00
e160db7a-016a-4487-bb91-ca5b6b7363af	lotto6	2146	2026-10-15	{15,17,19,34,36,37}	{3}	\N	t	2026-10-16 01:28:04.144357+00	2026-10-16 01:28:04.144357+00
13ad415f-db5b-4c5b-b67d-c8576a06f46a	lotto7	699	2026-10-16	{5,6,8,14,15,22,29}	{3,16}	\N	t	2026-10-18 03:23:56.672515+00	2026-10-18 03:23:56.672515+00
\.


--
-- Data for Name: notification_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."notification_records" ("id", "title", "body", "target", "sent_at", "created_at", "status", "updated_at") FROM stdin;
5f5dadab-dd23-4086-a94e-abc32ceddf71	Lotto 6 is available	New results are published. Open the app to view the winning numbers.	all	2026-10-01 15:48:52.575+00	2026-10-01 15:48:51.843995+00	sent	2026-10-01 15:48:52.575+00
05e5abcb-5eb4-463b-82c1-8934822eba2c	Lotto 6 is available	New results are published. Open the app to view the winning numbers.	all	2026-10-07 03:28:43.067+00	2026-10-07 03:28:42.327502+00	sent	2026-10-07 03:28:43.067+00
c570273e-c345-4458-9b97-d3ff7df70699	Lotto 7 is available	New results are published. Open the app to view the winning numbers.	all	2026-10-07 03:28:45.912+00	2026-10-07 03:28:45.070728+00	sent	2026-10-07 03:28:45.912+00
e5163ccd-69b8-4509-b165-b38724a004c5	Lotto 6 is available	New results are published. Open the app to view the winning numbers.	all	2026-10-14 22:48:15+00	2026-10-14 22:48:13.821275+00	sent	2026-10-14 22:48:15+00
9216abc6-733c-4123-b69c-a8cf747489db	Lotto 7 is available	New results are published. Open the app to view the winning numbers.	all	2026-10-14 22:48:16.374+00	2026-10-14 22:48:15.452432+00	sent	2026-10-14 22:48:16.374+00
c088d74a-f935-4111-9d43-d22de79c7e31	Lotto 6 results are live	Draw 2146 is published. Open the app to view winning numbers.	lotto6	2026-10-16 01:28:05.572+00	2026-10-16 01:28:05.147159+00	sent	2026-10-16 01:28:05.572+00
262d03cc-f524-4632-b49b-94c438d0be16	Lotto 7 results are live	Draw 699 is published. Open the app to view winning numbers.	lotto7	2026-10-18 03:23:58.183+00	2026-10-18 03:23:57.784665+00	sent	2026-10-18 03:23:58.183+00
\.


--
-- Data for Name: notification_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."notification_settings" ("id", "auto_notify_lotto6", "auto_notify_lotto7", "updated_at") FROM stdin;
465df4f6-d65a-4212-9bb8-0383ad877a53	t	t	2026-09-30 13:42:28.342978+00
\.


--
-- Data for Name: recommendations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."recommendations" ("id", "algorithm_id", "lottery_type", "numbers", "generated_at", "is_published", "bonus_numbers", "numbers_changed_at", "previous_numbers", "previous_bonus_numbers") FROM stdin;
4b0cdff6-6db2-4c03-9bd0-71459eebff7f	aaff0653-919b-4912-be10-a341186aab39	lotto6	{16,25,7,43,12,18}	2026-10-19 08:55:58.497824+00	f	{2}	2026-10-19 08:55:58.497824+00	{34,43,7,16,25,12}	{35}
47ab080c-2bd4-4d99-a1ea-ed833b720731	aaff0653-919b-4912-be10-a341186aab39	lotto6	{16,25,7,43,12,18}	2026-10-19 08:56:13.908758+00	t	{2}	2026-10-19 08:55:58.497824+00	{34,43,7,16,25,12}	{35}
5f429bd6-c0e9-49dd-8899-e969c6ce85b2	adc87b26-04a7-483d-aa5d-62bd2512e67c	lotto7	{1,10,23,24,28,32,36}	2026-10-19 08:55:59.371884+00	f	{2,34}	2026-10-19 08:55:59.371884+00	{1,6,15,24,23,29,34}	{2,16}
65be0abc-e97c-41fe-94a9-4428b9f6e00c	adc87b26-04a7-483d-aa5d-62bd2512e67c	lotto7	{1,10,23,24,25,33,34}	2026-10-19 08:56:15.162132+00	t	{2,9}	2026-10-19 08:56:15.162132+00	{1,10,23,24,28,32,36}	{2,34}
c04f91de-5b5a-4006-a74d-790ea2461cee	d0724d65-8fce-4d4f-8567-404e6ae2927a	lotto7	{1,9,11,17,18,20,25}	2026-10-19 08:56:00.261674+00	f	{2,26}	2026-10-19 08:56:00.261674+00	{7,3,8,14,15,20,25}	{1,9}
fa9c6bd0-e293-46a7-89c3-b7e8e42fc8b9	d0724d65-8fce-4d4f-8567-404e6ae2927a	lotto7	{7,9,11,13,18,20,25}	2026-10-19 08:56:16.461113+00	t	{1,26}	2026-10-19 08:56:16.461113+00	{1,9,11,17,18,20,25}	{2,26}
142d9e12-41b9-4617-ab8f-b5c8e8fe2ba3	88e1cb8e-95d6-4f25-a48e-7d24af22ac67	lotto7	{4,13,31,23,24,10,18}	2026-10-19 08:56:01.446711+00	f	{34,2}	2026-10-19 08:56:01.446711+00	{4,13,22,31,15,9,34}	{30,1}
f0c83cb1-9f62-4347-bdae-55e05e439594	88e1cb8e-95d6-4f25-a48e-7d24af22ac67	lotto7	{4,13,31,23,24,20,25}	2026-10-19 08:56:17.697075+00	t	{34,2}	2026-10-19 08:56:17.697075+00	{4,13,31,23,24,10,18}	{34,2}
9524b882-a4c1-4821-88d7-bb20f709c661	4dc34384-ba56-483c-9083-e88084ecd4a9	lotto6	{4,6,8,19,31,43}	2026-10-18 10:06:53.925552+00	f	{9}	2026-10-18 10:06:53.925552+00	\N	\N
5e86dc32-f5eb-41ff-ac50-72adad8ce56c	dc694945-2daf-4492-9b66-670e35cd7b27	lotto6	{2,8,14,11,21,27}	2026-10-18 10:06:54.087578+00	f	{1}	2026-10-18 10:06:54.087578+00	\N	\N
081f4641-584f-4cb3-99b0-f697e34e72e1	389dbfb2-2b8e-43b5-bd54-212f7bea848d	lotto6	{7,16,25,34,43,35}	2026-10-18 10:06:54.255131+00	f	{6}	2026-10-18 10:06:54.255131+00	\N	\N
20b1c46f-8320-4386-b424-21cd19dc2f4c	aaff0653-919b-4912-be10-a341186aab39	lotto6	{34,43,7,16,25,12}	2026-10-18 10:06:54.360776+00	f	{35}	2026-10-18 10:06:54.360776+00	\N	\N
b7216969-429e-479c-9ab1-47124f1e6bac	adc87b26-04a7-483d-aa5d-62bd2512e67c	lotto7	{1,6,15,24,23,29,34}	2026-10-18 10:06:54.519305+00	f	{2,16}	2026-10-18 10:06:54.519305+00	\N	\N
f33524ac-5f22-4035-a6e4-ded5aa791b05	d0724d65-8fce-4d4f-8567-404e6ae2927a	lotto7	{7,3,8,14,15,20,25}	2026-10-18 10:06:54.636145+00	f	{1,9}	2026-10-18 10:06:54.636145+00	\N	\N
d37b54f3-6c60-4247-bcb3-744d91843230	88e1cb8e-95d6-4f25-a48e-7d24af22ac67	lotto7	{4,13,22,31,15,9,34}	2026-10-18 10:06:54.761069+00	f	{30,1}	2026-10-18 10:06:54.761069+00	\N	\N
bb45cd7d-af1f-4c3f-9aa4-2c4caf073d3c	28c550bf-e16a-4134-8771-a878d91b8666	lotto7	{22,31,4,13,2,28,16}	2026-10-18 10:06:54.869412+00	f	{7,35}	2026-10-18 10:06:54.869412+00	\N	\N
c90e6902-ac9f-4ef0-be05-643a1c4b90b5	4dc34384-ba56-483c-9083-e88084ecd4a9	lotto6	{4,6,8,25,31,43}	2026-10-19 08:55:55.887618+00	f	{9}	2026-10-19 08:55:55.887618+00	{4,6,8,19,31,43}	{9}
27880347-ba66-4864-9162-3b8ca3c17519	4dc34384-ba56-483c-9083-e88084ecd4a9	lotto6	{4,6,8,25,31,43}	2026-10-19 08:56:10.072045+00	t	{1}	2026-10-19 08:56:10.072045+00	{4,6,8,25,31,43}	{9}
ca00a90d-db5c-4b63-a384-817f97065fcb	dc694945-2daf-4492-9b66-670e35cd7b27	lotto6	{6,4,14,11,21,27}	2026-10-19 08:55:57.179973+00	f	{1}	2026-10-19 08:55:57.179973+00	{2,8,14,11,21,27}	{1}
b301a67b-2cf4-4490-9d0f-63405344397c	dc694945-2daf-4492-9b66-670e35cd7b27	lotto6	{2,8,14,11,21,27}	2026-10-19 08:56:11.320295+00	t	{1}	2026-10-19 08:56:11.320295+00	{6,4,14,11,21,27}	{1}
58803496-1b36-4ff9-8140-d6e4f6d70459	389dbfb2-2b8e-43b5-bd54-212f7bea848d	lotto6	{7,16,25,43,6,11}	2026-10-19 08:55:58.054578+00	f	{1}	2026-10-19 08:55:58.054578+00	{7,16,25,34,43,35}	{6}
71c179cc-5af0-4d97-9186-4eae9d731fca	389dbfb2-2b8e-43b5-bd54-212f7bea848d	lotto6	{7,16,25,43,6,11}	2026-10-19 08:56:12.63877+00	t	{1}	2026-10-19 08:55:58.054578+00	{7,16,25,34,43,35}	{6}
1b292862-6019-4354-9930-0344cf667ee7	28c550bf-e16a-4134-8771-a878d91b8666	lotto7	{13,4,31,2,7,9,12}	2026-10-19 08:56:02.266538+00	f	{10,11}	2026-10-19 08:56:02.266538+00	{22,31,4,13,2,28,16}	{7,35}
f6d0ac91-9b5b-4eeb-a52c-5ff0a4149059	28c550bf-e16a-4134-8771-a878d91b8666	lotto7	{13,4,31,2,7,9,12}	2026-10-19 08:56:18.557271+00	t	{10,11}	2026-10-19 08:56:02.266538+00	{22,31,4,13,2,28,16}	{7,35}
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type", "versioning_status", "lifecycle_configuration", "lifecycle_configuration_generation") FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_analytics" ("name", "type", "format", "created_at", "updated_at", "id", "deleted_at") FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_vectors" ("id", "type", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata", "archived_at", "is_delete_marker", "is_versioned") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads" ("id", "in_progress_size", "upload_signature", "bucket_id", "key", "version", "owner_id", "created_at", "user_metadata", "metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads_parts" ("id", "upload_id", "size", "part_number", "bucket_id", "key", "etag", "owner_id", "version", "created_at") FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."vector_indexes" ("id", "name", "bucket_id", "data_type", "dimension", "distance_metric", "metadata_configuration", "created_at", "updated_at") FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 45, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict BVivy8vDd6UZvOc51lyqNbUWu9RAQod5Pg8b42iMBoe8eJC5U0y7HG6h9R81BPx

RESET ALL;
