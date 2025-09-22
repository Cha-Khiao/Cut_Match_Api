-- 1. ENABLE RLS
ALTER TABLE public.hairstyles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.favorites ENABLE ROW LEVEL SECURITY;

-- 2. POLICIES FOR hairstyles
CREATE POLICY "Public hairstyles are viewable by everyone"
ON public.hairstyles FOR SELECT USING (true);

-- 3. POLICIES FOR profiles
CREATE POLICY "Public profiles are viewable by everyone"
ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can update their own profile"
ON public.profiles FOR UPDATE USING (auth.uid() = id) WITH CHECK (auth.uid() = id);

-- 4. POLICIES FOR favorites
CREATE POLICY "Users can view their own favorites"
ON public.favorites FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own favorites"
ON public.favorites FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete their own favorites"
ON public.favorites FOR DELETE USING (auth.uid() = user_id);