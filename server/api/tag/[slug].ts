import { serverSupabaseClient } from '#supabase/server'

export default defineEventHandler(async (event) => {
  const client = await serverSupabaseClient(event)
  const slug = event.context.params?.slug
  
  if (!slug) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Tag slug is required'
    })
  }
  
  const { data, error } = await client
    .from('tags')
    .select('*')
    .eq('slug', slug)
    .single()
  
  if (error) {
    throw createError({
      statusCode: error.code === 'PGRST116' ? 404 : 500,
      statusMessage: error.code === 'PGRST116' ? 'Tag not found' : error.message
    })
  }
  
  return data
})
