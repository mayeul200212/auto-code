import { RESERVED_SLUGS } from "@/lib/organizations/reserved-slugs";
import { z } from "zod";

export const CreateOrgSchema = z.object({
  // We can add live check for slug availability
  slug: z.string().refine((v) => !RESERVED_SLUGS.includes(v), {
    message: "This organization slug is reserved",
  }),
  name: z.string(),
});

export type NewOrganizationSchemaType = z.infer<typeof CreateOrgSchema>;
