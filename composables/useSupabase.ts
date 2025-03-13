import { createClient } from '@supabase/supabase-js';

export const useSupabaseClient = () => {
  const config = useRuntimeConfig();
  
  const supabaseUrl = 'https://tcblwrhrgeaxfpcvmema.supabase.co';
  const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRjYmx3cmhyZ2VheGZwY3ZtZW1hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA3NzIxMTIsImV4cCI6MjA1NjM0ODExMn0.8bqwiq5uNZqA6aOxFAox4RsJ3SvJ1XyFmSKf2QWkuDQ';
  
  return createClient(supabaseUrl, supabaseKey);
};

export const useFrameworks = async () => {
  const supabase = useSupabaseClient();
  const { data: frameworks, error } = await supabase
    .from('framework')
    .select(`
      *,
      tags (*)
    `);
  
  if (error) {
    console.error('Error fetching frameworks:', error);
    return [];
  }
  
  return frameworks;
};

export const useFramework = async (slug: string) => {
  const supabase = useSupabaseClient();
  const { data: framework, error } = await supabase
    .from('framework')
    .select(`
      *,
      tags (*)
    `)
    .eq('slug', slug)
    .single();
  
  if (error) {
    console.error(`Error fetching framework with slug ${slug}:`, error);
    return null;
  }
  
  return framework;
};

export const useLibraries = async (frameworkId?: number) => {
  const supabase = useSupabaseClient();
  let query = supabase
    .from('library')
    .select(`
      *,
      framework (*),
      tags (*)
    `);
  
  if (frameworkId) {
    query = query.eq('framework', frameworkId);
  }
  
  const { data: libraries, error } = await query;
  
  if (error) {
    console.error('Error fetching libraries:', error);
    return [];
  }
  
  return libraries;
};

export const useLibrary = async (slug: string) => {
  const supabase = useSupabaseClient();
  const { data: library, error } = await supabase
    .from('library')
    .select(`
      *,
      framework (*),
      tags (*)
    `)
    .eq('slug', slug)
    .single();
  
  if (error) {
    console.error(`Error fetching library with slug ${slug}:`, error);
    return null;
  }
  
  return library;
};

export const useTags = async () => {
  const supabase = useSupabaseClient();
  const { data: tags, error } = await supabase
    .from('tags')
    .select('*');
  
  if (error) {
    console.error('Error fetching tags:', error);
    return [];
  }
  
  return tags;
};

export const useTag = async (slug: string) => {
  const supabase = useSupabaseClient();
  const { data: tag, error } = await supabase
    .from('tags')
    .select('*')
    .eq('slug', slug)
    .single();
  
  if (error) {
    console.error(`Error fetching tag with slug ${slug}:`, error);
    return null;
  }
  
  return tag;
};

export const useLibrariesByTag = async (tagId: number) => {
  const supabase = useSupabaseClient();
  const { data: libraries, error } = await supabase
    .from('library')
    .select(`
      *,
      framework (*),
      tags!inner (*)
    `)
    .eq('tags.id', tagId);
  
  if (error) {
    console.error(`Error fetching libraries with tag ID ${tagId}:`, error);
    return [];
  }
  
  return libraries;
};

export const useFrameworksByTag = async (tagId: number) => {
  const supabase = useSupabaseClient();
  const { data: frameworks, error } = await supabase
    .from('framework')
    .select(`
      *,
      tags!inner (*)
    `)
    .eq('tags.id', tagId);
  
  if (error) {
    console.error(`Error fetching frameworks with tag ID ${tagId}:`, error);
    return [];
  }
  
  return frameworks;
};

export const useSearch = async (query: string) => {
  const supabase = useSupabaseClient();
  
  // Search libraries
  const { data: libraries, error: librariesError } = await supabase
    .from('library')
    .select(`
      *,
      framework (*),
      tags (*)
    `)
    .or(`name.ilike.%${query}%,description.ilike.%${query}%`);
  
  if (librariesError) {
    console.error('Error searching libraries:', librariesError);
  }
  
  // Search frameworks
  const { data: frameworks, error: frameworksError } = await supabase
    .from('framework')
    .select(`
      *,
      tags (*)
    `)
    .or(`name.ilike.%${query}%,description.ilike.%${query}%`);
  
  if (frameworksError) {
    console.error('Error searching frameworks:', frameworksError);
  }
  
  return {
    libraries: libraries || [],
    frameworks: frameworks || []
  };
};
