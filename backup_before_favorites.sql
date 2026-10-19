


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."lottery_type" AS ENUM (
    'lotto6',
    'lotto7'
);


ALTER TYPE "public"."lottery_type" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  new.updated_at = now();
  return new;
end;
$$;


ALTER FUNCTION "public"."set_updated_at"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."algorithms" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "lottery_type" "public"."lottery_type" NOT NULL,
    "is_enabled" boolean DEFAULT true NOT NULL,
    "parameters" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."algorithms" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."app_settings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "privacy_policy_url" "text" DEFAULT ''::"text" NOT NULL,
    "terms_of_service_url" "text" DEFAULT ''::"text" NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."app_settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."draws" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "lottery_type" "public"."lottery_type" NOT NULL,
    "draw_number" "text" NOT NULL,
    "draw_date" "date" NOT NULL,
    "winning_numbers" integer[] NOT NULL,
    "bonus_numbers" integer[] DEFAULT '{}'::integer[] NOT NULL,
    "prize_info" "text",
    "is_published" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."draws" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notification_records" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "body" "text" NOT NULL,
    "target" "text" NOT NULL,
    "sent_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "status" "text" DEFAULT 'draft'::"text" NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "notification_records_status_check" CHECK (("status" = ANY (ARRAY['draft'::"text", 'sent'::"text"]))),
    CONSTRAINT "notification_records_target_check" CHECK (("target" = ANY (ARRAY['lotto6'::"text", 'lotto7'::"text", 'all'::"text"])))
);


ALTER TABLE "public"."notification_records" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notification_settings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "auto_notify_lotto6" boolean DEFAULT true NOT NULL,
    "auto_notify_lotto7" boolean DEFAULT true NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."notification_settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."recommendations" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "algorithm_id" "uuid" NOT NULL,
    "lottery_type" "public"."lottery_type" NOT NULL,
    "numbers" integer[] NOT NULL,
    "generated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "is_published" boolean DEFAULT false NOT NULL,
    "bonus_numbers" integer[] DEFAULT '{}'::integer[] NOT NULL
);


ALTER TABLE "public"."recommendations" OWNER TO "postgres";


ALTER TABLE ONLY "public"."algorithms"
    ADD CONSTRAINT "algorithms_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."app_settings"
    ADD CONSTRAINT "app_settings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."draws"
    ADD CONSTRAINT "draws_lottery_type_draw_number_key" UNIQUE ("lottery_type", "draw_number");



ALTER TABLE ONLY "public"."draws"
    ADD CONSTRAINT "draws_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notification_records"
    ADD CONSTRAINT "notification_records_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notification_settings"
    ADD CONSTRAINT "notification_settings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."recommendations"
    ADD CONSTRAINT "recommendations_pkey" PRIMARY KEY ("id");



CREATE OR REPLACE TRIGGER "draws_set_updated_at" BEFORE UPDATE ON "public"."draws" FOR EACH ROW EXECUTE FUNCTION "public"."set_updated_at"();



ALTER TABLE ONLY "public"."recommendations"
    ADD CONSTRAINT "recommendations_algorithm_id_fkey" FOREIGN KEY ("algorithm_id") REFERENCES "public"."algorithms"("id") ON DELETE CASCADE;



CREATE POLICY "Authenticated manage algorithms" ON "public"."algorithms" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Authenticated manage app settings" ON "public"."app_settings" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Authenticated manage draws" ON "public"."draws" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Authenticated manage notification settings" ON "public"."notification_settings" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Authenticated manage notifications" ON "public"."notification_records" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Authenticated manage recommendations" ON "public"."recommendations" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Authenticated read all draws" ON "public"."draws" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Public read algorithms" ON "public"."algorithms" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "Public read app settings" ON "public"."app_settings" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "Public read published draws" ON "public"."draws" FOR SELECT TO "authenticated", "anon" USING (("is_published" = true));



CREATE POLICY "Public read published recommendations" ON "public"."recommendations" FOR SELECT TO "authenticated", "anon" USING (("is_published" = true));



ALTER TABLE "public"."algorithms" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."app_settings" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."draws" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notification_records" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notification_settings" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."recommendations" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






















































































































































GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_updated_at"() TO "service_role";


















GRANT ALL ON TABLE "public"."algorithms" TO "anon";
GRANT ALL ON TABLE "public"."algorithms" TO "authenticated";
GRANT ALL ON TABLE "public"."algorithms" TO "service_role";



GRANT ALL ON TABLE "public"."app_settings" TO "anon";
GRANT ALL ON TABLE "public"."app_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."app_settings" TO "service_role";



GRANT ALL ON TABLE "public"."draws" TO "anon";
GRANT ALL ON TABLE "public"."draws" TO "authenticated";
GRANT ALL ON TABLE "public"."draws" TO "service_role";



GRANT ALL ON TABLE "public"."notification_records" TO "anon";
GRANT ALL ON TABLE "public"."notification_records" TO "authenticated";
GRANT ALL ON TABLE "public"."notification_records" TO "service_role";



GRANT ALL ON TABLE "public"."notification_settings" TO "anon";
GRANT ALL ON TABLE "public"."notification_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."notification_settings" TO "service_role";



GRANT ALL ON TABLE "public"."recommendations" TO "anon";
GRANT ALL ON TABLE "public"."recommendations" TO "authenticated";
GRANT ALL ON TABLE "public"."recommendations" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































