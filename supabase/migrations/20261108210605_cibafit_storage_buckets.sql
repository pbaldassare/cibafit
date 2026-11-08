-- CibaFit: bucket Storage separati da quelli di Cibarius. Le policy valgono solo per i bucket cibafit-*.
set local role postgres;
set local lock_timeout = '5s';
set local search_path = pg_catalog;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types) values ('cibafit-media', 'cibafit-media', true, null, null);
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types) values ('cibafit-avatars', 'cibafit-avatars', true, null, null);
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types) values ('cibafit-item-photos', 'cibafit-item-photos', true, null, null);
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types) values ('cibafit-haccp-documents', 'cibafit-haccp-documents', true, null, null);
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types) values ('cibafit-haccp-photos', 'cibafit-haccp-photos', false, 10485760, array['image/jpeg','image/png','image/webp','image/heic','image/heif']);

create policy "cibafit: Admin manages HACCP photos" on storage.objects as permissive for all to authenticated using (((bucket_id = 'cibafit-haccp-photos'::text) AND cibafit.current_user_is_admin())) with check (((bucket_id = 'cibafit-haccp-photos'::text) AND cibafit.current_user_is_admin()));
create policy "cibafit: Anyone can read avatars" on storage.objects as permissive for select to public using ((bucket_id = 'cibafit-avatars'::text));
create policy "cibafit: Anyone can read media" on storage.objects as permissive for select to public using ((bucket_id = 'cibafit-media'::text));
create policy "cibafit: Anyone can view item photos" on storage.objects as permissive for select to public using ((bucket_id = 'cibafit-item-photos'::text));
create policy "cibafit: Authenticated users can delete item photos" on storage.objects as permissive for delete to authenticated using ((bucket_id = 'cibafit-item-photos'::text));
create policy "cibafit: Authenticated users can read media" on storage.objects as permissive for select to public using (((bucket_id = 'cibafit-media'::text) AND (auth.uid() IS NOT NULL)));
create policy "cibafit: Authenticated users can upload item photos" on storage.objects as permissive for insert to authenticated with check ((bucket_id = 'cibafit-item-photos'::text));
create policy "cibafit: Authenticated users can upload to own folder" on storage.objects as permissive for insert to public with check (((bucket_id = 'cibafit-media'::text) AND (auth.uid() IS NOT NULL) AND ((((storage.foldername(name))[1] = 'users'::text) AND ((storage.foldername(name))[2] = (auth.uid())::text)) OR ((storage.foldername(name))[1] = 'restaurants'::text))));
create policy "cibafit: Authenticated users upload avatars" on storage.objects as permissive for insert to authenticated with check ((bucket_id = 'cibafit-avatars'::text));
create policy "cibafit: Authenticated users upload media" on storage.objects as permissive for insert to authenticated with check ((bucket_id = 'cibafit-media'::text));
create policy "cibafit: Public read avatars" on storage.objects as permissive for select to public using ((bucket_id = 'cibafit-avatars'::text));
create policy "cibafit: Restaurant reads HACCP photos" on storage.objects as permissive for select to authenticated using (((bucket_id = 'cibafit-haccp-photos'::text) AND
CASE
    WHEN ((storage.foldername(name))[1] ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'::text) THEN cibafit.is_restaurant_accessible(((storage.foldername(name))[1])::uuid)
    ELSE false
END));
create policy "cibafit: Restaurant uploads HACCP photos" on storage.objects as permissive for insert to authenticated with check (((bucket_id = 'cibafit-haccp-photos'::text) AND
CASE
    WHEN ((storage.foldername(name))[1] ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'::text) THEN cibafit.is_restaurant_accessible(((storage.foldername(name))[1])::uuid)
    ELSE false
END));
create policy "cibafit: Users can delete own media" on storage.objects as permissive for delete to public using (((bucket_id = 'cibafit-media'::text) AND (auth.uid() IS NOT NULL) AND ((((storage.foldername(name))[1] = 'users'::text) AND ((storage.foldername(name))[2] = (auth.uid())::text)) OR ((storage.foldername(name))[1] = 'restaurants'::text))));
create policy "cibafit: Users can update own media" on storage.objects as permissive for update to public using (((bucket_id = 'cibafit-media'::text) AND (auth.uid() IS NOT NULL) AND ((((storage.foldername(name))[1] = 'users'::text) AND ((storage.foldername(name))[2] = (auth.uid())::text)) OR ((storage.foldername(name))[1] = 'restaurants'::text))));
create policy "cibafit: Users delete own avatar" on storage.objects as permissive for delete to public using (((bucket_id = 'cibafit-avatars'::text) AND (auth.uid() IS NOT NULL) AND ((storage.foldername(name))[1] = (auth.uid())::text)));
create policy "cibafit: Users delete own avatars" on storage.objects as permissive for delete to authenticated using (((bucket_id = 'cibafit-avatars'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));
create policy "cibafit: Users delete own media" on storage.objects as permissive for delete to authenticated using (((bucket_id = 'cibafit-media'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));
create policy "cibafit: Users update own avatar" on storage.objects as permissive for update to public using (((bucket_id = 'cibafit-avatars'::text) AND (auth.uid() IS NOT NULL) AND ((storage.foldername(name))[1] = (auth.uid())::text)));
create policy "cibafit: Users update own avatars" on storage.objects as permissive for update to authenticated using (((bucket_id = 'cibafit-avatars'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));
create policy "cibafit: Users update own media" on storage.objects as permissive for update to authenticated using (((bucket_id = 'cibafit-media'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));
create policy "cibafit: Users upload own avatar" on storage.objects as permissive for insert to public with check (((bucket_id = 'cibafit-avatars'::text) AND (auth.uid() IS NOT NULL) AND ((storage.foldername(name))[1] = (auth.uid())::text)));
create policy "cibafit: haccp docs auth delete" on storage.objects as permissive for delete to public using (((bucket_id = 'cibafit-haccp-documents'::text) AND (auth.uid() IS NOT NULL)));
create policy "cibafit: haccp docs auth update" on storage.objects as permissive for update to public using (((bucket_id = 'cibafit-haccp-documents'::text) AND (auth.uid() IS NOT NULL)));
create policy "cibafit: haccp docs auth upload" on storage.objects as permissive for insert to public with check (((bucket_id = 'cibafit-haccp-documents'::text) AND (auth.uid() IS NOT NULL)));
create policy "cibafit: haccp docs public read" on storage.objects as permissive for select to public using ((bucket_id = 'cibafit-haccp-documents'::text));
